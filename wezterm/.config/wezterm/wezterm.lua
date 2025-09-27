-- ~/.config/wezterm/wezterm.lua
local wezterm = require("wezterm")

-- Use the builder if available (adds nice error messages)
local config = wezterm.config_builder and wezterm.config_builder() or {}

-- Shell
config.default_prog = { "/usr/bin/zsh" } -- adjust if needed

-- Font
config.font = wezterm.font("Inconsolata-dz") -- ensure installed; or use font_with_fallback
config.font_size = 12.0
config.cell_width = 0.85
-- config.line_height = 1.0  -- optional

-- Freetype rendering
config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"

-- UI
config.enable_tab_bar = false
config.window_decorations = "RESIZE"

-- Colors: choose ONE of the following approaches

-- (A) Explicit colors:
config.colors = {
  foreground = "#c0c0c0",
  background = "#1a1c1c",
}

-- (B) Or use a builtin scheme (uncomment to use and remove the explicit colors above)
-- config.color_scheme = "Catppuccin Mocha"

-- Optional: middle-click paste from clipboard
-- config.mouse_bindings = {
--   {
--     event = { Up = { streak = 1, button = "Middle" } },
--     action = wezterm.action.PasteFrom("Clipboard"),
--   },
-- }

return config
