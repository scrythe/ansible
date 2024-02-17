return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			custom_highlights = function(colors)
				return {
					Comment = { fg = colors.subtext0},
					LineNr = { fg = colors.blue},
				}
			end,
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
