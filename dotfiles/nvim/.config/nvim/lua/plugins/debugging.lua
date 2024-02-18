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
    "leoluz/nvim-dap-go",
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
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
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
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

    require("dap-vscode-js").setup({
      debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),
      adapters = { "pwa-node", "pwa-chrome" }, -- which adapters to register in nvim-dap
    })

    require("dap-go").setup()

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
