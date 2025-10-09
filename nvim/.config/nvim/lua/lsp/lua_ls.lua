vim.lsp.config["lua_ls"] = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_dir = vim.fs.root(0, {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  }),
  capabilities = require("blink.cmp").get_lsp_capabilities(),
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = {
        globals = { "vim" },
        disable = { "trailing-space" },
      },
      workspace = { checkThirdParty = false },
      completion = { callSnippet = "Replace" },
      telemetry = { enable = false },
    },
  },
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua" },
  callback = function()
    vim.lsp.start(vim.lsp.config["lua_ls"])
  end,
})
