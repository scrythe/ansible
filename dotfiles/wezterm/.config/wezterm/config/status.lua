local wezterm = require("wezterm")

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
