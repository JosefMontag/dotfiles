
return {
  {
    'R-nvim/R.nvim',
    lazy = false,
    version = '~0.1.0',
    config = function()
      require('r').setup {
        hook = {
          on_filetype = function()
            vim.env.RNVIMSERVER = vim.v.servername
            vim.keymap.set('n', '<Enter>', '<Plug>RDSendLine', { buffer = true })
            vim.keymap.set('v', '<Enter>', '<Plug>RSendSelection', { buffer = true })
          end,
        },
        external_term = 'wezterm',
        R_args = { '--quiet', '--no-save' },
      }
    end,
  },
  { 'R-nvim/cmp-r', dependencies = { 'hrsh7th/nvim-cmp' }, config = function()
      require('cmp').setup { sources = { { name = 'cmp_r' } } }
      require('cmp_r').setup {}
    end,
  },
}
