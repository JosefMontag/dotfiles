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
config.window_close_confirmation = "NeverPrompt" 


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
--
-- local wezterm = require 'wezterm'

config.keys = {
    -- Existing key bindings go here, or add this block if 'keys' doesn't exist.
    
    -- Explicitly define Shift-RightArrow to send the correct sequence.
    -- This should override any conflicting default behavior.
    { key = "RightArrow", mods = "SHIFT", action = wezterm.action.SendString("\x1b[1;2C") },
  }

return config
