-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

local act = wezterm.action

config.color_scheme = "catppuccin-mocha"

config.use_fancy_tab_bar = false
config.status_update_interval = 1000

wezterm.on("update-right-status", function(window, pane)
	local stat = window:active_workspace()

	local time = wezterm.strftime("%H:%M:%S")

	local battery_decimal = wezterm.battery_info()[1].state_of_charge
	local battery = string.format("%.0f%%", battery_decimal * 100)
	local cwd_uri = pane:get_current_working_dir()

	local cwd = cwd_uri and cwd_uri.file_path:match("[^/]*$") or "-"

	window:set_right_status(wezterm.format({
		{ Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
		{ Text = " | " },
		{ Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
		{ Text = " | " },
		{ Text = wezterm.nerdfonts.md_battery .. "  " .. battery },
		{ Text = "  " },
		{ Text = wezterm.nerdfonts.md_clock .. "  " .. time },
		{ Text = " | " },
	}))
end)

config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	{
		key = "t",
		mods = "CTRL",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "w",
		mods = "CTRL",
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
}

return config
