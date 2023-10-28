local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath);

require("lazy").setup({
    {
    'nvim-telescope/telescope.nvim', tag = '0.1.3',
-- or                              , branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    -- { 'rose-pine/neovim', name = 'rose-pine' },
    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
    {'ThePrimeagen/harpoon'},
    {'mbbill/undotree'},
    {'tpope/vim-fugitive'},
    
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},

    {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {'L3MON4D3/LuaSnip'},
    {'ThePrimeagen/vim-be-good'},
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { 'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons', opt = true } },
    {'lewis6991/gitsigns.nvim'},
})
