return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = { integrations = { bufferline = true } },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme 'catppuccin'
      vim.api.nvim_set_hl(0, 'Visual', { bg = '#b37457', fg = 'black' })
      vim.api.nvim_set_hl(0, 'YankHighlight', { bg = '#ffa500', fg = 'black' })
    end,
  },
  {
    'akinsho/bufferline.nvim',
    dependencies = { 'catppuccin/nvim' },
    config = function()
      require('bufferline').setup {
        options = { show_buffer_icons = false, separator_style = 'thin', always_show_bufferline = false },
      }
    end,
  },
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup { view_options = { show_hidden = true } }
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
  },
}
