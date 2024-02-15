local wezterm = require("wezterm")
local act = wezterm.action

local function format(label, current)
	local Foreground = current and { Color = "white" } or { AnsiColor = "Teal" }
	local Background = current and { Color = "orange" } or { Color = "Green" }
	return wezterm.format({
		{ Foreground = Foreground },
		{ Background = Background },
		{ Text = " " .. wezterm.nerdfonts.oct_table .. "  " .. label },
	})
end

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
	local active_workspaces = wezterm.mux.get_workspace_names()
	local workspaces = {}
	local current_workspace = wezterm.mux.get_active_workspace()
	table.insert(workspaces, { id = current_workspace, label = format(current_workspace, true) })
	for _, workspace in ipairs(active_workspaces) do
		if current_workspace == workspace then
			goto continue
		end
		table.insert(workspaces, {
			id = workspace,
			label = format(workspace, false),
		})
		::continue::
	end
	for folderPath in folderPathsString:gmatch("[^\n]+") do
		table.insert(workspaces, { id = folderPath, label = folderPath })
	end
	return workspaces
end

return function(window, pane)
	local workspaces = getWorkspaces()

	window:perform_action(
		act.InputSelector({
			action = wezterm.action_callback(function(inner_window, inner_pane, id)
				if not id then
					return
				end
				local label = id:match("([^/]+)$")
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
