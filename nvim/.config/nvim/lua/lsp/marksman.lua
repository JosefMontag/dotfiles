local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config["marksman"] = {
  cmd = { "marksman", "server" },
  capabilities = capabilities,
}
vim.lsp.start(vim.lsp.config["marksman"])
