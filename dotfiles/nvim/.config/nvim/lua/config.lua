vim.g.mapleader = " "
vim.opt.relativenumber = true

-- vim.opt.cursorline = true
vim.opt.autoread = true

-- use spaces for tabs and whatnot
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

-- vim.cmd [[ set termguicolors ]]
vim.opt.colorcolumn = "80"

vim.cmd("set clipboard+=unnamedplus")

vim.keymap.set("i", "<C-c>", "<ESC>", {})
