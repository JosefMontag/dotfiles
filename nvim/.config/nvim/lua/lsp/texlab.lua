local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config["texlab"] = {
  cmd = { "texlab" },
  capabilities = capabilities,
  settings = {
    texlab = {
      build = {
        executable = "latexmk",
        args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
        onSave = true,
      },
      forwardSearch = {
        executable = "zathura",
        args = { "--synctex-forward", "%l:1:%f", "%p" },
      },
    },
  },
}
vim.lsp.start(vim.lsp.config["texlab"])
