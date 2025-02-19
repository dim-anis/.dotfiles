-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Colors & Appearance
config.color_scheme = "catppuccin-mocha"
config.window_decorations = "RESIZE"
config.enable_tab_bar = false

-- Fonts
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 16.0

return config
