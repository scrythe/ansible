require("dap").adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    -- 💀 Make sure to update this path to point to your installation
    args = {"/home/scrythe/js-debug/src/dapDebugServer.js", "${port}"},
  }
}

require("dap").configurations.javascript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
}

require("dap").configurations.typescript = {
    {
    type = "pwa-node",
    request = "launch",
    name = "tsx",
    -- "request": "launch",
    program = "${file}",
    runtimeExecutable = "${workspaceRoot}/node_modules/.bin/tsx",

    console = "integratedTerminal",
    internalConsoleOptions = "neverOpen",

    -- skipFiles = [
    --     // Node.js internal core modules
    --     "<node_internals>/**",
    --
    --     // Ignore all dependencies (optional)
    --     "${workspaceFolder}/node_modules/**",
    -- ],
    }
}


vim.keymap.set("n", "<leader>dt", ":DapUiToggle<CR>", {noremap=true})
vim.keymap.set("n", "<leader>db", ":DapToggleBreakpoint<CR>", {noremap=true})
vim.keymap.set("n", "<leader>dr", ":DapContinue<CR>", {noremap=true})
-- vim.keymap.set("n", "<leader>dc", ":DapContinue<CR>", {noremap=true})
-- vim.keymap.set("n", "<leader>dr", "lua :require('dapui').open({reset = true})<CR>", {noremap=true})
