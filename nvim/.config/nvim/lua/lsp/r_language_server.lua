local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config["r_language_server"] = {
  cmd = { "R", "--slave", "-e", "languageserver::run()" },
  filetypes = { "r", "rmd", "qmd", "rnoweb" },
  capabilities = capabilities,
}
vim.lsp.start(vim.lsp.config["r_language_server"])
