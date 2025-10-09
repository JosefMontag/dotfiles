return {
  {
    "Vigemus/iron.nvim",
    lazy = false,
    config = function()
      local wezterm_cmd = { "wezterm", "start", "--", "radian" }

      -- Start WezTerm with Radian if not running, get its pane id
      local function ensure_wezterm_radian()
        if vim.g.wezterm_radian_pane_id then
          return vim.g.wezterm_radian_pane_id
        end

        -- Launch new Radian instance
        vim.fn.jobstart(wezterm_cmd, { detach = true })
        vim.defer_fn(function()
          local pane_id = vim.fn.systemlist(
            [[wezterm cli list --format json | jq -r '.[] | select(.title | test("radian"; "i")) | .pane_id']]
          )[1]
          if pane_id and pane_id ~= "" then
            vim.g.wezterm_radian_pane_id = pane_id
            vim.notify("Connected to Radian pane " .. pane_id)
          else
            vim.notify("Couldn't locate Radian pane", vim.log.levels.WARN)
          end
        end, 800)
      end

      -- Send code string to WezTerm Radian
      local function send_to_wezterm(code)
        ensure_wezterm_radian()
        local pane_id = vim.g.wezterm_radian_pane_id
        if not pane_id then
          return
        end
        local escaped = code:gsub("\n", "\r\n")
        vim.fn.system({ "wezterm", "cli", "send-text", "--pane-id", pane_id, "--", escaped .. "\r" })
      end

      local iron = require("iron.core")

      iron.setup({
        config = {
          repl_definition = {
            r = { command = { "true" } }, -- placeholder, we override sending
            R = { command = { "true" } },
            quarto = { command = { "true" } },
          },
          scratch_repl = false,
          repl_open_cmd = function()
            return vim.api.nvim_get_current_win()
          end,
          visibility = require("iron.visibility").hidden,
        },
        keymaps = {
          send_line = "<Enter>", -- Send current line in normal mode
          visual_send = "<Enter>", -- Send selection in visual mode
          send_paragraph = "<leader>rs", -- Send R function/chunk
          send_until_cursor = "<leader>ru", -- Send from start to cursor
          interrupt = "<C-c>", -- Interrupt running code
          exit = "<leader>rq", -- Close REPL
        },
        highlight = false,
        ignore_blank_lines = true,
      })

      -- Patch Iron's send() so that R code goes to WezTerm instead of a REPL buffer
      local orig_send = iron.send
      iron.send = function(ft, data)
        if ft == "r" or ft == "R" or ft == "quarto" then
          send_to_wezterm(data)
        else
          orig_send(ft, data)
        end
      end

      -- Manual controls
      vim.keymap.set("n", "<localleader>rf", function()
        vim.g.wezterm_radian_pane_id = nil
        ensure_wezterm_radian()
      end, { desc = "[R]EPL [S]tart Radian in WezTerm" })

      vim.keymap.set("n", "<localleader>rq", function()
        if vim.g.wezterm_radian_pane_id then
          vim.fn.system({ "wezterm", "cli", "send-text", "--pane-id", vim.g.wezterm_radian_pane_id, "--", "q()\r" })
          vim.g.wezterm_radian_pane_id = nil
          vim.notify("Closed Radian session")
        end
      end, { desc = "Quit Radian" })
    end,
  },
}
