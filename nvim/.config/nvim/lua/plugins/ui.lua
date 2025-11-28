return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = { integrations = { bufferline = true } },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
      vim.api.nvim_set_hl(0, "Visual", { bg = "#b37457", fg = "black" })
      vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#ffa500", fg = "black" })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = { "catppuccin/nvim" },
    config = function()
      require("bufferline").setup({
        options = { show_buffer_icons = false, separator_style = "thin", always_show_bufferline = false },
      })
    end,
  },
  {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        view_options = {
          show_hidden = true,
          natural_order = true,
        },
        float = {
          padding = 2,
          max_width = 90,
          max_height = 0,
        },
        win_options = {
          wrap = true,
          winblend = 0,
        },
        keymaps = {
          ["<C-c>"] = false,
          ["q"] = "actions.close",
        },
      })
      vim.keymap.set("n", "<leader>f", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
  },
  {
    "mikavilpas/yazi.nvim",
    version = "*", -- use the latest stable version
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>-",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>cw",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        "<c-up>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = true,
      keymaps = {
        show_help = "<f1>",
      },
    },
    -- 👇 if you use `open_for_directories=true`, this is recommended
    init = function()
      -- mark netrw as loaded so it's not loaded at all.
      --
      -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
      vim.g.loaded_netrwPlugin = 1
    end,
  },
}
