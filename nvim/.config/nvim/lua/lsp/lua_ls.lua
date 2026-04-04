return {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = {
        globals = { "vim", "wezterm" }, -- Added wezterm for your config editing
        disable = { "trailing-space" },
      },
      workspace = { checkThirdParty = false },
      completion = { callSnippet = "Replace" },
      telemetry = { enable = false },
    },
  },
}
