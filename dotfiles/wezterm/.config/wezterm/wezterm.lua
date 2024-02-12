-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

local act = wezterm.action

config.color_scheme = "catppuccin-mocha"

config.use_fancy_tab_bar = false
config.status_update_interval = 1000

config.default_prog = { "/usr/bin/zsh" }

-- local success, stdout, stderr = wezterm.run_child_process { 'find ~/projects ~/coding_lessons ~/godot-games -mindepth 1 -maxdepth 1 -type d' }
-- local success, stdout, stderr = wezterm.run_child_process({ "ls", "-l" })
--
-- wezterm.log_info(success)
-- wezterm.log_info(stdout)
-- wezterm.log_info(stderr)

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
		action = wezterm.action_callback(function(window, pane)
			-- Here you can dynamically construct a longer list if needed

			local home = wezterm.home_dir
			local _, folderPathsString = wezterm.run_child_process({
				"find",
				home .. "/projects",
				home .. "/coding_lessons",
				home .. "/godot-games",
				"-mindepth",
				"1",
				"-maxdepth",
				"1",
				"-type",
				"d",
			})
			local workspaces = { { id = home, label = "default" } }
			for folderPath in folderPathsString:gmatch("[^\n]+") do
				table.insert(workspaces, { id = folderPath, label = folderPath })
			end

			window:perform_action(
				act.InputSelector({
					action = wezterm.action_callback(function(inner_window, inner_pane, id,label)
						label = label:match("([^/]+)$")
						wezterm.log_info("id = " .. id)
						wezterm.log_info("label = " .. label)
						inner_window:perform_action(
							act.SwitchToWorkspace({
								name = label,
								spawn = {
									label = "Workspace: " .. label,
									cwd = id,
								},
							}),
							inner_pane
						)
					end),
					title = "Choose Workspace",
					choices = workspaces,
					fuzzy = true,
					fuzzy_description = "Fuzzy find and/or make a workspace: ",
				}),
				pane
			)
		end),
	},
}

return config
