return {
  "folke/which-key.nvim",
  dependencies = { { "echasnovski/mini.nvim", version = false } },
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function()
    local wk = require("which-key")
    wk.add({
      { "<leader>d", group = "debug" },
      { "<leader>f", group = "find" },
      { "<leader>g", group = "git/format" },
      { "<leader>l", group = "rename" },
    })
    wk.add({
      mode = { "v" },
      { "<leader>s", group = "Silicon" },
      {
        "<leader>sc",
        function()
          require("nvim-silicon").clip()
        end,
        desc = "Copy code screenshot to clipboard",
      },
      {
        "<leader>sf",
        function()
          require("nvim-silicon").file()
        end,
        desc = "Save code screenshot as file",
      },
      {
        "<leader>ss",
        function()
          require("nvim-silicon").shoot()
        end,
        desc = "Create code screenshot",
      },
    })
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
}
