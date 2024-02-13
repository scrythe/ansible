local wezterm = require("wezterm")
local act = wezterm.action

M = {}
M.applyConfig = function(config)
  config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }

  config.keys = {
    {
      key = "t",
      mods = "LEADER",
      action = act.SpawnTab("CurrentPaneDomain"),
    },
    {
      key = "w",
      mods = "LEADER",
      action = act.CloseCurrentTab({ confirm = false }),
    },
    {
      key = "1",
      mods = "CTRL",
      action = wezterm.action.ActivateTab(0),
    },
    {
      key = "2",
      mods = "CTRL",
      action = wezterm.action.ActivateTab(1),
    },
    {
      key = "3",
      mods = "CTRL",
      action = wezterm.action.ActivateTab(2),
    },
    {
      key = "4",
      mods = "CTRL",
      action = wezterm.action.ActivateTab(3),
    },
    {
      key = "s",
      mods = "CTRL|SHIFT",
      action = act.SwitchToWorkspace({
        name = "monitoring",
      }),
    },
    {
      key = "9",
      mods = "ALT",
      action = act.ShowLauncherArgs({
        flags = "FUZZY|WORKSPACES",
      }),
    },
    {
      key = "S",
      mods = "CTRL|SHIFT",
      action = wezterm.action_callback(require("config.fzfworkspace")),
    },
  }
end
return M
