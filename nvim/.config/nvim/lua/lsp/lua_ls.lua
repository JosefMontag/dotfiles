local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config["lua_ls"] = {
  cmd = { "lua-language-server" },
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}
vim.lsp.start(vim.lsp.config["lua_ls"])
