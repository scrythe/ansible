return function(dap, dapui)
  local js_based_languages = {
    "typescript",
    "javascript",
    "typescriptreact",
    "javascriptreact",
  }

  vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
  vim.keymap.set("n", "<leader>dB", function()
    dap.toggle_breakpoint(vim.fn.input("Breakpoint condition: "))
  end, { desc = "Toggle Breakpoint Condition" })
  vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Dap Continue" })
  vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Dap Stepinto" })
  vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Dap Stepout" })
  vim.keymap.set("n", "<leader>dO", dap.step_over, { desc = "Dap Stepover" })
  vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate Dap Session" })
  vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DapUi" })
  vim.keymap.set("n", "<leader>de", dapui.eval, { desc = "Dap eval" })
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
