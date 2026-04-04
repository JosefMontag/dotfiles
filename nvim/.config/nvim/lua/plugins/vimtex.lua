return {
  "lervag/vimtex",
  lazy = false,
  ft = { "tex" },
  config = function()
    vim.g.vimtex_mappings_enabled = 0 -- disable default global mappings

    -- core VimTeX setup
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk = {
      build_dir = "build",
      continuous = 1,
      callback = 1,
      options = {
        "-pdf",
        "-shell-escape",
        "-interaction=nonstopmode",
        "-synctex=1",
      },
    } -- The table is properly closed here now

    -- re-create local mappings just for TeX
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "tex",
      callback = function()
        vim.keymap.set("n", "<leader>ll", ":VimtexCompile<CR>", { buffer = true, desc = "Compile LaTeX" })
        vim.keymap.set("n", "<leader>lv", ":VimtexView<CR>", { buffer = true, desc = "View PDF in Zathura" })
      end,
    })
  end,
}
