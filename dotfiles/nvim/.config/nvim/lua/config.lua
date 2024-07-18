vim.g.mapleader = " "
vim.opt.number = true
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

vim.keymap.set("i", "<C-c>", "<ESC>")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

vim.keymap.set("x", "<leader>p", [["_dP]])
