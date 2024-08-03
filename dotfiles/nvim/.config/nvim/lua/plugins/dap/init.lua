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
    "nvim-neotest/nvim-nio",
    "mxsdev/nvim-dap-vscode-js",
    {
      "Joakker/lua-json5",
      build = "./install.sh",
    },
    "leoluz/nvim-dap-go",
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    require("plugins.dap.keybinds")(dap,dapui)

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
    -- dapui.widgets'.centered_float(require'dap.ui.widgets'.frames)

    dap.defaults.codelldb.exception_breakpoints = { 'rust_panic' }
    -- require("dap-vscode-js").setup({
    --   debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),
    --   adapters = { "pwa-node", "pwa-chrome" }, -- which adapters to register in nvim-dap
    -- })
    require('dap.ext.vscode').load_launchjs(nil, { codelldb = { 'rust' } })
    require("dap-go").setup()
    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        -- 💀 Make sure to update this path to point to your installation
        args = { "/home/scrythe/Downloads/js-debug/src/dapDebugServer.js", "${port}" },
      }
    }
  end,
}
