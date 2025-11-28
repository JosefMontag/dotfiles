local map = vim.keymap.set

-- Search highlighting
map("n", "<leader>n", ":set invhls<CR>")
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("n", "q", "<cmd>q<CR>")

-- Move selected text
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Quick commands
map("n", ";", ":")
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

-- Window navigation
map("n", "<leader>h", "<C-w>h")
map("n", "<leader>l", "<C-w>l")
map("n", "<leader>j", "<C-w>j")
map("n", "<leader>k", "<C-w>k")
map("n", "<leader>o", "<C-w>o")

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
