-- ~/.config/nvim/lua/pandoc_build.lua

local function build_pandoc()
  if vim.bo.filetype ~= "markdown" then
    return
  end

  local md = vim.fn.expand("%:r") .. ".md"
  local pdf = vim.fn.expand("%:r") .. ".pdf"
  local beamer = false

  for line in io.lines(vim.fn.expand("%:p")) do
    if line:match("beamer") then
      beamer = true
      break
    end
  end

  local cmd
  if beamer then
    cmd = { "pandoc", md, "-o", pdf, "--pdf-engine-opt=--recorder", "-t", "beamer", "--slide-level=2" }
  else
    cmd = { "pandoc", md, "-o", pdf, "--pdf-engine-opt=--recorder" }
  end

  vim.fn.jobstart(cmd, { detach = true })
  print("Building PDF in background...")
end

local function view_pdf()
  vim.fn.jobstart({ "zathura", vim.fn.expand("%:r") .. ".pdf" }, { detach = true })
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.keymap.set("n", "<leader>ll", build_pandoc, { buffer = true })
    vim.keymap.set("n", "<leader>lv", view_pdf, { buffer = true })
  end,
})
