-- File: lua/lsp/pylsp.lua
return {
  -- This is often required for the client to pass it during the 'initialize' phase
  init_options = {
    skip_token_initialization = true,
  },
  settings = {
    pylsp = {
      -- This is the standard settings location
      skip_token_initialization = true,
      plugins = {
        pycodestyle = { enabled = false },
        mccabe = { enabled = false },
      },
    },
  },
}
