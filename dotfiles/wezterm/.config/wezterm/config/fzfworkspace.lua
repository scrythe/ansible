local wezterm = require("wezterm")
local act = wezterm.action

local function getWorkspaces()
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
	return workspaces
end

return function(window, pane)
	local workspaces = getWorkspaces()

	window:perform_action(
		act.InputSelector({
			action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
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
end
