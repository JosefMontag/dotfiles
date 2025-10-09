local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config["air"] = {
  cmd = { "air", "language-server" },
  filetypes = { "r" },
  root_dir = vim.fs.root(0, { "air.toml", ".air.toml", ".git" }),
  capabilities = capabilities,
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "r",
  callback = function()
    vim.lsp.start(vim.lsp.config["air"])
  end,
})

-- local capabilities = require("blink.cmp").get_lsp_capabilities()
--
-- vim.lsp.config["r_language_server"] = {
--   cmd = { "R", "--slave", "-e", "languageserver::run()" },
--   filetypes = { "r", "rmd", "qmd", "rnoweb" },
--   capabilities = capabilities,
-- }
-- vim.lsp.start(vim.lsp.config["r_language_server"])
