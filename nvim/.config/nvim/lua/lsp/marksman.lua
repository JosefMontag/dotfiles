local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config["marksman"] = {
  cmd = { "marksman", "server" },
  filetypes = { "markdown", "quarto" },
  root_dir = vim.fs.root(0, { ".marksman.toml", "_quarto.yml", ".git" }),
  capabilities = capabilities,
}

-- Optionally autostart:
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "quarto" },
  callback = function()
    vim.lsp.start(vim.lsp.config["marksman"])
  end,
})
