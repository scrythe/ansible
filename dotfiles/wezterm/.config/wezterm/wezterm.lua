-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
-- local config = {}

config.color_scheme = "catppuccin-mocha"

config.use_fancy_tab_bar = false
config.status_update_interval = 1000

config.default_prog = { "/usr/bin/zsh" }

require("config.status")
require("config.keys").applyConfig(config)
-- local success, stdout, stderr =
-- 	wezterm.run_child_process({ "zoxide", "query", "-l" })
-- wezterm.log_info(success)
-- wezterm.log_info(stdout)
-- wezterm.log_info(stderr)

return config
