return {
  -- No need to define 'cmd' or 'filetypes' if using nvim-lspconfig/Mason
  -- They already know how to talk to R.
  settings = {
    -- Any specific R settings go here
    r = {
      lsp = {
        rich_documentation = true,
      },
    },
  },
}
