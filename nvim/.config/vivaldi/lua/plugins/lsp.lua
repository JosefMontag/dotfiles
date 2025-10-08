return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'hrsh7th/cmp-nvim-lsp',
    { 'j-hui/fidget.nvim', opts = {} },
    'stevearc/conform.nvim',
  },

  config = function()
    ---------------------------------------------------------------------------
    -- 1. Capabilities
    ---------------------------------------------------------------------------
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
    if ok then
      capabilities = vim.tbl_deep_extend('force', capabilities, cmp_lsp.default_capabilities())
    end

    ---------------------------------------------------------------------------
    -- 2. Servers to install
    ---------------------------------------------------------------------------
    local servers = { 'lua_ls', 'marksman', 'texlab' }

    ---------------------------------------------------------------------------
    -- 3. Mason setup
    ---------------------------------------------------------------------------
    require('mason').setup()
    require('mason-tool-installer').setup {
      ensure_installed = { 'lua-language-server', 'marksman', 'texlab', 'stylua' },
    }

    require('mason-lspconfig').setup {
      ensure_installed = servers,
    }

    ---------------------------------------------------------------------------
    -- 4. LSP server configuration (new API)
    ---------------------------------------------------------------------------
    local lsp = vim.lsp.config

    -- Lua LS
    lsp('lua_ls', {
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          diagnostics = { globals = { 'vim' } },
          disable = { 'deprecated' },
          workspace = {
            library = vim.api.nvim_get_runtime_file('', true),
            checkThirdParty = false,
          },
          completion = { callSnippet = 'Replace' },
        },
      },
    })

    -- Markdown (marksman)
    lsp('marksman', {
      capabilities = capabilities,
    })

    -- LaTeX (texlab)
    lsp('texlab', {
      capabilities = capabilities,
    })

    ---------------------------------------------------------------------------
    -- 5. Diagnostics
    ---------------------------------------------------------------------------
    local signs = { Error = 'E', Warn = 'W', Hint = 'H', Info = 'I' }
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    vim.diagnostic.config {
      virtual_text = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = { border = 'rounded', source = true },
    }

    ---------------------------------------------------------------------------
    -- 6. Formatter setup (Conform)
    ---------------------------------------------------------------------------
    require('conform').setup {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local ft = vim.bo[bufnr].filetype
        local disable_filetypes = { tex = true, r = true, rmd = true }
        local lsp_format_opt = disable_filetypes[ft] and 'never' or 'fallback'
        return { timeout_ms = 500, lsp_format = lsp_format_opt }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
      },
      formatters = {
        stylua = {
          prepend_args = { '--indent-type', 'Spaces', '--indent-width', '2' },
        },
      },
    }

    ---------------------------------------------------------------------------
    -- 7. Diagnostic navigation keymaps
    ---------------------------------------------------------------------------
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev diagnostic' })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
    vim.keymap.set('n', 'gl', function()
      vim.diagnostic.open_float(nil, { scope = 'cursor', border = 'rounded' })
    end, { desc = 'Show diagnostic under cursor' })
  end,
}
