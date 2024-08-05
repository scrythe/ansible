local nio = require("nio")
local bps = require("plugins.dap.save_breakpoints")
local number = 0
function bla()
	number = number + 1
end

local function toggleExpr(dapui)
	local currentExpr = nio.fn.expand("<cexpr>")
	local exprs = dapui.elements.watches.get()
	for id, expr in ipairs(exprs) do
		if expr.expression == currentExpr then
			return dapui.elements.watches.remove(id)
		end
	end
	dapui.elements.watches.add()
end

return function(dap, dapui)
	local js_based_languages = {
		"typescript",
		"javascript",
		"typescriptreact",
		"javascriptreact",
	}

	vim.keymap.set("n", "<leader>db", function()
		dap.toggle_breakpoint()
		bps.store_breakpoints(false)
	end, { desc = "Toggle Breakpoint" })
	vim.keymap.set("n", "<leader>dB", function()
		dap.toggle_breakpoint(vim.fn.input("Breakpoint condition: "))
		bps.store_breakpoints(false)
		vim.keymap.set("n", "<leader>dC", function()
			dap.clear_breakpoints()
			bps.store_breakpoints(true)
		end, { desc = "Clear Breakpoints" })
	end, { desc = "Toggle Breakpoint Condition" })
	vim.api.nvim_create_autocmd("BufRead", {
		pattern = "*",
		callback = function()
			bps.load_breakpoints()
		end,
	})
	vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Dap Continue" })
	vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Dap Stepinto" })
	vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Dap Stepout" })
	vim.keymap.set("n", "<leader>dO", dap.step_over, { desc = "Dap Stepover" })
	vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate Dap Session" })
	vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DapUi" })
	vim.keymap.set("n", "<leader>de", dapui.eval, { desc = "Dap eval" })
	vim.keymap.set("n", "E", function()
		toggleExpr(dapui)
	end, { desc = "Dap eval" })
	vim.keymap.set("n", "<leader>da", function()
		if vim.fn.filereadable(".vscode/launch.json") then
			local dap_vscode = require("dap.ext.vscode")
			dap_vscode.load_launchjs(nil, {
				["pwa-node"] = js_based_languages,
				["pwa-chrome"] = js_based_languages,
			})
		end
		dap.continue()
	end, { desc = "Dap with Args" })
end
