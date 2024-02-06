return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        current_line_blame = true,
        current_line_blame_opts = {
          delay = 0,
        },
      })
      vim.keymap.set("n", "gp", "<cmd>Gitsigns preview_hunk_inline<CR>", { desc = "Git preview Hunk" })
    end,
  },
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Open Git Fugitive Window" })
    end,
  },
}
