return {
  'mrcjkb/rustaceanvim',
  version = '^4', -- Recommended
  lazy = false,   -- This plugin is already lazy
  init = function()
    vim.g.rustaceanvim = {
      dap = {
        -- autoload_configurations = false
        -- configuration = function()
        --   local dap_config = {
        --     name = 'Rust debug client',
        --     type = "codelldb",
        --     request = 'launch',
        --     stopOnEntry = false,
        --     env = {
        --       ["RUST_BACKTRACE"] = "5"
        --     }
        --   }
        --   ---@diagnostic disable-next-line: different-requires
        --   local dap = require('dap')
        --   -- Load configurations from a `launch.json`.
        --   -- It is necessary to check for changes in the `dap.configurations` table, as
        --   -- `load_launchjs` does not return anything, it loads directly into `dap.configurations`.
        --   local pre_launch = vim.deepcopy(dap.configurations) or {}
        --   require('dap.ext.vscode').load_launchjs(nil, { lldb = { 'rust' }, codelldb = { 'rust' } })
        --   for name, configuration_entries in pairs(dap.configurations) do
        --     if pre_launch[name] == nil or not vim.deep_equal(pre_launch[name], configuration_entries) then
        --       for _, entry in pairs(configuration_entries) do
        --         if entry.type == type then
        --           dap_config = entry
        --           break
        --         end
        --       end
        --     end
        --   end
        --   return dap_config
        -- end
        -- {
        --   dap = {
        --     configuration = {
        --       -- env = {
        --       --   -- RUST_BACKTRACE = "1"
        --       -- }
        --     }
        --   }
        -- }
      }
    }
  end
}
