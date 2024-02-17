return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			view = { number = true, relativenumber = true },
			update_focused_file = {
				enable = true,
				update_root = false,
			},
		})
		vim.keymap.set("n", "<leader>e", "<cmd>:NvimTreeToggle<CR>", { desc = "Open File Tree" })
	end,
}
