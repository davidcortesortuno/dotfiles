local wezterm = require("wezterm")
local act = wezterm.action
local config = {}

config.font = wezterm.font("Fira Code")
config.font_size = 13.0
config.color_scheme = "Desert"
config.hide_mouse_cursor_when_typing = false

config.keys = {
    -- This will create a new split and run your default program inside it
    {
        key = "j",
        mods = "CTRL|SHIFT",
        action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
    },
    {
        key = "h",
        mods = "CTRL|SHIFT",
        action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
    },
    { key = "RightArrow", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
    { key = "LeftArrow", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
    { key = "DownArrow", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
    { key = "UpArrow", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Up" }) },

    -- { key = "b", mods = "CTRL", action = wezterm.action.RotatePanes("CounterClockwise") },

    -- { key = "n", mods = "CTRL", action = wezterm.action.RotatePanes("Clockwise") },
    
    -- Disable alt+enter for fullscreen
    {
      key = 'Enter',
      mods = 'ALT',
      action = wezterm.action.DisableDefaultAssignment,
    },
}

-- Change mouse scroll amount
config.mouse_bindings = {
  {
    event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    mods = 'NONE',
    action = act.ScrollByLine(-1),
  },
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = 'NONE',
    action = act.ScrollByLine(1),
  },
}

-- Spawn a fish shell in login mode
config.default_prog = { "/usr/bin/fish", "-l" }

return config
