local wezterm = require("wezterm")
local config = wezterm.config_builder and wezterm.config_builder() or {}

-- Shell
config.default_prog = { "/usr/bin/zsh" }

-- Font
config.font = wezterm.font("InconsolataGo Nerd Font") -- Match Neovim
config.font_size = 14.0 -- Match Neovim
config.cell_width = 0.85
config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"

-- UI
config.enable_tab_bar = false
config.window_decorations = "TITLE | RESIZE" -- Ensure wmctrl works
config.exit_behavior = "CloseOnCleanExit" -- Stable for radian

-- Colors
config.colors = {
  foreground = "#c0c0c0",
  background = "#1a1c1c",
}
-- Optional: Match Neovim’s Catppuccin
-- config.color_scheme = "Catppuccin Mocha"

-- Middle-click paste
-- config.mouse_bindings = {
--   {
--     event = { Up = { streak = 1, button = "Middle" } },
--     action = wezterm.action.PasteFrom("Clipboard"),
--   },
-- }

return config
