return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			view = { relativenumber = true },
		})
		vim.keymap.set("n", "<leader>e", "<cmd>:NvimTreeToggle<CR>")
	end,
}
