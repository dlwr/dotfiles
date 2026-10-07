local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font 'Cica'
config.font_size = 13
config.line_height = 1.05

config.colors = {
  background = '#fdf6e3',
  foreground = '#586e75',
  ansi = { '#073642', '#dc322f', '#859900', '#b58900', '#268bd2', '#d33682', '#2aa198', '#eee8d5' },
  brights = { '#002b36', '#cb4b16', '#586e75', '#657b83', '#839496', '#6c71c4', '#93a1a1', '#fdf6e3' },
}

config.window_padding = { left = 4, right = 4, top = 4, bottom = 4 }

config.use_ime = true
config.macos_forward_to_ime_modifier_mask = 'SHIFT|CTRL'
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

local function clipboard_has_only_image()
  local ok, info = wezterm.run_child_process { 'osascript', '-e', 'clipboard info' }
  if not ok then return false end
  local has_text = info:find('utf8', 1, true) or info:find('string', 1, true)
  local has_image = info:find('PNGf', 1, true) or info:find('TIFF', 1, true)
  return has_image and not has_text
end

config.keys = {
  {
    key = 'v',
    mods = 'CMD',
    action = wezterm.action_callback(function(window, pane)
      if clipboard_has_only_image() then
        window:perform_action(wezterm.action.SendKey { key = 'v', mods = 'CTRL' }, pane)
      else
        window:perform_action(wezterm.action.PasteFrom 'Clipboard', pane)
      end
    end),
  },
}

config.default_prog = { '/opt/homebrew/bin/zsh', '-l', '-c', '/Users/yuta25/.local/bin/herdr; exec /opt/homebrew/bin/zsh -l' }

return config
