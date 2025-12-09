-- ~/.config/nvim/init.luaa
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Ensure lua/ is in runtime path
vim.opt.rtp:prepend(vim.fn.stdpath("config") .. "/lua")

-- Load settings and keymaps
require("settings")
require("keymaps")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { import = "plugins.workflow" },
  { import = "plugins.r" },
  { import = "plugins.vimtex" },
  { import = "plugins.lsp" },
  { import = "plugins.treesitter" },
  { import = "plugins.ui" },
  { import = "plugins.git" },
}, {
  change_detection = {
    enabled = true,
    notify = true,
  },
})

require("markdown")
