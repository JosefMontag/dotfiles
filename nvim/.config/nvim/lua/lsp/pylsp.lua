-- File: lua/lsp/pylsp.lua
-- In 0.11+, we return a table that Neovim merges automatically
return {
  settings = {
    pylsp = {
      -- FIX: Stops the TimeoutErrors causing your typing lag
      skip_token_initialization = true,
      plugins = {
        pycodestyle = { enabled = false },
        mccabe = { enabled = false },
        flake8 = { enabled = true },
      },
    },
  },
}
