-- General options
vim.cmd 'filetype plugin indent on'
vim.opt.guifont = 'InconsolataGo Nerd Font:h14'
vim.g.have_nerd_font = true

-- Interface
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.scrolloff = 7
vim.opt.colorcolumn = '80'
vim.opt.foldmethod = 'marker'
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.textwidth = 0
vim.opt.virtualedit = 'block'
vim.opt.cursorline = false
vim.opt.termguicolors = true
vim.opt.timeoutlen = 500
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Tabs and indentation
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.inccommand = 'split'

-- Undo and file handling
vim.opt.undofile = true
vim.opt.undodir = os.getenv 'HOME' .. '/GD/4SYNCFILES/nvim/clutter/undo'
vim.opt.shadafile = os.getenv 'HOME' .. '/GD/4SYNCFILES/nvim/clutter/main.shada'
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.autochdir = true

-- Autosave {{{1

-- Auto-save only if buffer actually changed by the user
vim.opt.updatetime = 3000

-- Main autosave logic
local save_on_events = { 'InsertLeave', 'TextChanged' }

vim.api.nvim_create_autocmd(save_on_events, {
  callback = function()
    local file = vim.fn.expand '%:p'
    local bufnr = vim.api.nvim_get_current_buf()

    -- Only save real, modified files, not temp/help/config
    if
      vim.bo[bufnr].modifiable
      and vim.bo[bufnr].modified
      and vim.api.nvim_buf_get_option(bufnr, 'buftype') == ''
      and file ~= ''
      and not file:match '/%.config/nvim/'
      and not vim.b._just_loaded
    then
      vim.cmd 'silent! write'
    end
  end,
  desc = 'Auto-save only if buffer was changed',
})

-- Grace period to avoid saving right after opening a file
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    vim.b._just_loaded = true
    vim.defer_fn(function()
      vim.b._just_loaded = false
    end, 1000) -- ignore first 1s after load
  end,
})

-- Yank highlight and clipboard copy
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  pattern = '*',
  callback = function()
    if vim.v.event.operator == 'y' then
      vim.fn.system('xclip -selection primary -in', vim.fn.getreg '"')
      vim.highlight.on_yank { higroup = 'YankHighlight', timeout = 200 }
    end
  end,
})

-- Disable auto-commenting on new lines
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove 't'
  end,
})

-- Show diagnostics automatically when the mouse hovers
vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
  callback = function()
    vim.diagnostic.open_float(nil, {
      focus = false,
      scope = 'cursor',
      border = 'rounded',
    })
  end,
})
