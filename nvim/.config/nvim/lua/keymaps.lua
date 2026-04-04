local map = vim.keymap.set

-- Search highlighting
map("n", "<leader>n", ":set invhls<CR>")
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("n", "q", "<cmd>q<CR>")

-- Move selected text
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Quick commands
map("n", "<cr>", ":")
map("n", "<leader><leader>", "i<space><esc>")
map("n", "<leader>ev", ":e $MYVIMRC<CR>")
map("n", "<leader>so", function()
  vim.cmd("source $MYVIMRC")
  vim.notify("Sourced init.lua", vim.log.levels.INFO)
end)

-- Buffers
map("n", "<TAB>", ":BufferLineCycleNext<CR>")
map("n", "<S-TAB>", ":b#<CR>")
map("n", "<leader>ls", ":ls<CR>")
map("n", "<leader>c", ":bw<CR>")
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics" })
map("n", "<leader>o", ":only<CR>")

-- Function to move between splits easily
local function map_split_nav(key, direction)
  vim.keymap.set({ "n", "t" }, key, function()
    vim.cmd("wincmd " .. direction)
  end, { desc = "Move to " .. direction .. " split" })
end

-- Map Alt + Arrows (which is Alt + Ctrl + hjkl via Kanata)
map_split_nav("<M-Left>", "h")
map_split_nav("<M-Down>", "j")
map_split_nav("<M-Up>", "k")
map_split_nav("<M-Right>", "l")

-- If you want to create splits easily with Alt+Shift+Arrows:
vim.keymap.set("n", "<M-S-Right>", "<cmd>vsplit<CR>", { desc = "Vertical Split" })
vim.keymap.set("n", "<M-S-Down>", "<cmd>split<CR>", { desc = "Horizontal Split" })

-- Clipboard behavior
map("x", "p", '"_dP')
map("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Run selected Lua
_G.run_selected_lua_code = function()
  local s, e = vim.fn.line("'<"), vim.fn.line("'>")
  local code = table.concat(vim.fn.getline(s, e), "\n")
  local ok, err = pcall(loadstring(code))
  if not ok then
    vim.notify(err, vim.log.levels.ERROR)
  end
end
map("v", "<leader>rl", _G.run_selected_lua_code)

-- Slime {{{1

-- r.lua

local function jump_to_next_code()
  local total_lines = vim.api.nvim_buf_line_count(0)
  local curr_line = vim.api.nvim_win_get_cursor(0)[1]
  local next_line = curr_line + 1

  while next_line <= total_lines do
    local content = vim.fn.getline(next_line)
    -- Skip empty lines and comments
    if content:match("%S") and not content:match("^%s*#") then
      vim.api.nvim_win_set_cursor(0, { next_line, 0 })
      return
    end
    next_line = next_line + 1
  end
end

local function smart_send()
  local ok, ts_utils = pcall(require, "nvim-treesitter.ts_utils")
  local node = ok and ts_utils.get_node_at_cursor() or nil

  if node then
    local root = node
    -- Find the outer logical block
    while root:parent() and root:parent():type() ~= "module" do
      local t = root:type()
      if t:match("definition") or t:match("loop") or t:match("if_statement") then
        break
      end
      root = root:parent()
    end

    local s_r, _, e_r, _ = root:range()

    -- Set Neovim's native visual marks to the Treesitter block
    vim.api.nvim_buf_set_mark(0, "<", s_r + 1, 0, {})
    vim.api.nvim_buf_set_mark(0, ">", e_r + 1, 0, {})

    -- Execute Slime directly on those marks
    vim.cmd("'<,'>SlimeSend")

    -- Move cursor to end of block
    vim.api.nvim_win_set_cursor(0, { e_r + 1, 0 })
  else
    -- Fallback: Set marks to the current line and send
    local line = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_buf_set_mark(0, "<", line, 0, {})
    vim.api.nvim_buf_set_mark(0, ">", line, 0, {})
    vim.cmd("'<,'>SlimeSend")
  end

  -- Slight delay ensures the send finishes before the jump
  vim.defer_fn(jump_to_next_code, 20)
end

-- Keymaps
vim.keymap.set("n", "<CR>", smart_send, { silent = true, desc = "Send block to Zellij" })

vim.keymap.set("v", "<CR>", function()
  -- Exit visual mode so the '< and '> marks are locked in
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", false)
  -- Send the marked region
  vim.cmd("'<,'>SlimeSend")
  vim.defer_fn(jump_to_next_code, 50)
end, { silent = true, desc = "Send visual to Zellij" })
