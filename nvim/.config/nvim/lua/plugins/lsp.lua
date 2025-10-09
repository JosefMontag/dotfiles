return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", config = true },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    { "j-hui/fidget.nvim", opts = {} },
    "stevearc/conform.nvim",
    {
      "saghen/blink.cmp",
      version = "*",
      dependencies = {
        "rafamadriz/friendly-snippets",
        "echasnovski/mini.icons",
      },
      config = function()
        require("blink.cmp").setup({
          sources = {
            default = { "lsp", "path", "buffer", "snippets" },
          },
          keymap = { preset = "default" },
          completion = {
            list = { selection = { preselect = true } },
            documentation = { auto_show = true, auto_show_delay_ms = 200 },
            windows = {
              completion = { border = "rounded" },
              documentation = { border = "rounded" },
            },
          },
        })
      end,
    },
  },

  config = function()
    -- Mason & installer
    require("mason").setup()
    require("mason-tool-installer").setup({
      ensure_installed = { "lua-language-server", "marksman", "texlab", "stylua" },
    })
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "marksman", "texlab" },
    })

    -- Diagnostics styling
    vim.diagnostic.config({
      virtual_text = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = { border = "rounded", source = true },
    })

    -- Formatter (conform.nvim)
    require("conform").setup({
      notify_on_error = false,
      format_on_save = function(bufnr)
        local ft = vim.bo[bufnr].filetype
        local disable_filetypes = { tex = true, r = true, rmd = true }
        local lsp_format_opt = disable_filetypes[ft] and "never" or "fallback"
        return { timeout_ms = 500, lsp_format = lsp_format_opt }
      end,
      formatters_by_ft = { lua = { "stylua" } },
      formatters = {
        stylua = {
          prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        },
      },
    })

    -- Load individual LSP servers (stored in lua/lsp/*.lua)
    require("lsp.lua_ls")
    require("lsp.marksman")
    require("lsp.r_language_server")
    require("lsp.texlab")

    -- Keymaps and LSP attach behaviour
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
          return
        end

        local bufnr = args.buf
        if client.server_capabilities.completionProvider then
          pcall(vim.lsp.completion.enable, bufnr)
        end
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr, desc = "Prev diagnostic" })
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr, desc = "Next diagnostic" })
        vim.keymap.set("n", "gl", function()
          vim.diagnostic.open_float(nil, { scope = "cursor", border = "rounded" })
        end, { buffer = bufnr, desc = "Show diagnostic under cursor" })
      end,
    })
  end,
}
