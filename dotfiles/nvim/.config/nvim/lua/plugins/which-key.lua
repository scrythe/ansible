return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function()
    local wk = require("which-key")
    wk.register({
      ["<leader>"] = {
        f = { name = "+find" },
        d = { name = "+debug" },
        g = { name = "+git/format" },
        l = { name = "+rename" },
      },
    })
    wk.register({
      ['s'] = {
        name = "Silicon",
        ['s'] = { function() require("nvim-silicon").shoot() end, "Create code screenshot" },
        ['f'] = { function() require("nvim-silicon").file() end, "Save code screenshot as file" },
        ['c'] = { function() require("nvim-silicon").clip() end, "Copy code screenshot to clipboard" },
      },
    }, { prefix = "<leader>", mode = "v" })
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
}
