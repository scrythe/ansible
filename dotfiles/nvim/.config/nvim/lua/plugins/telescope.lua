return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
      vim.keymap.set("n", "<leader>fG", builtin.git_commits, { desc = "Find Git Commits" })
      vim.keymap.set("n", "<leader>fb", builtin.git_branches, { desc = "Find Git Branches" })
    end,
    -- keys = {
    --   { "<leader>ff", "<cmd> Telescope find_files <CR>", desc = "Find files" },
    -- },
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
  {
    "ThePrimeagen/git-worktree.nvim",
    config = function()
      -- require("git-worktree").setup()
      vim.keymap.set("n", "<leader>fw", "<CMD>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
        { desc = "Show Workspaces" })
      vim.keymap.set("n", "<leader>fW",
        "<CMD>:lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", { desc = "Create Workspace" })
      require("telescope").load_extension("git_worktree")
    end
  }
}
