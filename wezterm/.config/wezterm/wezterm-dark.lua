local wezterm = require "wezterm"
local config = {}

config.default_prog =
  { "/usr/bin/env", "tmux", "new-session", "-A", "-s", "main" }

config.default_cursor_style = "SteadyBar"
config.audible_bell = "Disabled"

-- lucius
config.colors = {}

-- Tab Bar {{{1
-- config.hide_tab_bar_if_only_one_tab = true
-- config.use_fancy_tab_bar = false
config.enable_tab_bar = false
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.window_decorations = "NONE"

-- Font {{{1
config.adjust_window_size_when_changing_font_size = false
config.font_size = 10.0
default_font = os.getenv "FONT" or "JetbrainsMono Light"
bold_font = os.getenv "FONT_BOLD" or "JetbrainsMono ExtraBold"
ignore_svg_fonts = true

config.font = wezterm.font(default_font)
config.font_rules = {
  { -- normal and italic
    intensity = "Half",
    font = wezterm.font(default_font),
  },
  { -- normal and italic
    intensity = "Normal",
    italic = true,
    font = wezterm.font(default_font, { style = "Italic" }),
  },
  { -- bold
    intensity = "Bold",
    italic = false,
    font = wezterm.font(bold_font),
  },
  { -- bold and italic
    intensity = "Bold",
    italic = true,
    font = wezterm.font(bold_font, { style = "Italic" }),
  },
}

return config