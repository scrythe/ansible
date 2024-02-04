return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"microsoft/vscode-js-debug",
			-- After install, build it and rename the dist directory to out
			build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
			version = "1.*",
		},
		"rcarriga/nvim-dap-ui",
		"mxsdev/nvim-dap-vscode-js",
		{
			"Joakker/lua-json5",
			build = "./install.sh",
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		local js_based_languages = {
			"typescript",
			"javascript",
			"typescriptreact",
			"javascriptreact",
		}
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, {})
		vim.keymap.set("n", "<leader>dc", function()
			if vim.fn.filereadable(".vscode/launch.json") then
				local dap_vscode = require("dap.ext.vscode")
				dap_vscode.load_launchjs(nil, {
					["pwa-node"] = js_based_languages,
					["pwa-chrome"] = js_based_languages,
				})
			end
			dap.continue()
		end)

		require("dap-vscode-js").setup({
			debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),
			adapters = { "pwa-node", "pwa-chrome" }, -- which adapters to register in nvim-dap
			-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
			-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
			-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
		})

		for _, language in ipairs(js_based_languages) do
			dap.configurations[language] = {
				-- Debug single nodejs files
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
				},
				-- Debug nodejs processes (make sure to add --inspect when you run the process)
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					processId = require("dap.utils").pick_process,
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
				},
				-- Debug web applications (client side)
				{
					type = "pwa-chrome",
					request = "launch",
					name = "Launch & Debug Chrome",
					url = function()
						local co = coroutine.running()
						return coroutine.create(function()
							vim.ui.input({
								prompt = "Enter URL: ",
								default = "http://localhost:3000",
							}, function(url)
								if url == nil or url == "" then
									return
								else
									coroutine.resume(co, url)
								end
							end)
						end)
					end,
					webRoot = vim.fn.getcwd(),
					protocol = "inspector",
					sourceMaps = true,
					userDataDir = false,
				},
				-- {
				-- name = "Debug tsx",
				-- type = "pwa-node",
				-- request = "launch",
				-- program = "${file}",
				-- cwd = vim.fn.getcwd(),
				-- runtimeExecutable = "${workspaceFolder}/apps/backend/node_modules/.bin/tsx",
				-- sourceMaps = true,
				-- console = "integratedTerminal",
				-- internalConsoleOptions = "neverOpen",
				-- skipFiles = {
				-- "<node_internals>/**",
				-- "${workspaceFolder}/node_modules/**",
				-- },
				-- },
				-- launch.jso version
				-- {
				-- "version": "0.2.0",
				-- "configurations": [
				-- {
				-- "name": "tsx yeet",
				-- "type": "pwa-node",
				-- "request": "launch",
				-- "program": "${file}",
				-- "runtimeExecutable": "${workspaceFolder}/apps/backend/node_modules/.bin/tsx",
				-- "sourceMaps": true,
				-- "console": "integratedTerminal",
				-- "internalConsoleOptions": "neverOpen",
				-- "skipFiles": [
				-- "<node_internals>/**",
				-- "${workspaceFolder}/node_modules/**"
				-- ],
				-- "cwd": "${workspaceFolder}"
				-- }
				-- ]
				-- }
				-- Divider for the launch.json derived configs
				{
					name = "----- ↓ launch.json configs ↓ -----",
					type = "",
					request = "launch",
				},
			}
		end
	end,
}
