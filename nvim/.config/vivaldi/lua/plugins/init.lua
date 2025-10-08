-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', 'https://github.com/folke/lazy.nvim.git', lazypath }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { import = 'plugins.workflow' },
  { import = 'plugins.r' },
  { import = 'plugins.editing' },
  { import = 'plugins.lsp' },
  { import = 'plugins.treesitter' },
  { import = 'plugins.ui' },
}, {
  change_detection = {
    enabled = true, -- <== disables auto reload
    notify = true, -- or leave true if you still want to be notified
  },
})
