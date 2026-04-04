return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", config = true },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "stevearc/conform.nvim",
    {
      "saghen/blink.cmp",
      version = "*",
      opts = {
        keymap = { preset = "default" },
        sources = {
          default = { "lsp", "path", "buffer", "snippets" },
        },
      },
    },
  },

  config = function()
    -- 1. Mason setup
    require("mason").setup()
    require("mason-tool-installer").setup({
      ensure_installed = { "stylua", "codelldb" },
    })

    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "marksman", "texlab", "pylsp" },
    })

    -- 2. Modern 0.11+ Server Activation
    local servers = { "lua_ls", "marksman", "texlab", "pylsp", "r_language_server" }

    for _, server in ipairs(servers) do
      local ok, custom_settings = pcall(require, "lsp." .. server)
      
      -- Only assign to vim.lsp.config if the file exists and returns a table
      if ok and type(custom_settings) == "table" then
        vim.lsp.config[server] = custom_settings
      end

      -- Enable the server
      vim.lsp.enable(server)
    end

    -- 3. Diagnostics (MUST be inside config function)
    vim.diagnostic.config({
      virtual_text = true,
      float = { border = "rounded" },
    })

    -- 4. Keymaps (MUST be inside config function)
    vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next diagnostic" })
    vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Prev diagnostic" })
  end, -- This 'end' closes the config function
} -- This '}' closes the return table
