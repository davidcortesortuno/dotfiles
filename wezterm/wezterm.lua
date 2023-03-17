local wezterm = require 'wezterm';
return {
  font = wezterm.font("Fira Code"),
  font_size = 13.0,
  color_scheme = "Desert",

  keys = {
    -- This will create a new split and run your default program inside it
    {key="j", mods="CTRL|SHIFT",
      action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    {key="l", mods="CTRL|SHIFT",
      action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},

    {key="RightArrow", mods="ALT",
      action=wezterm.action{ActivatePaneDirection="Right"}},

    {key="LeftArrow", mods="ALT",
      action=wezterm.action{ActivatePaneDirection="Left"}},

    {key="DownArrow", mods="ALT",
      action=wezterm.action{ActivatePaneDirection="Down"}},

    {key="UpArrow", mods="ALT",
      action=wezterm.action{ActivatePaneDirection="Up"}},
  }
}
