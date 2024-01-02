-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'
	-- Fuzzy finder
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.4',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	-- Colorscheme
	use 'navarasu/onedark.nvim'
	-- Abstract syntax tree support
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}
	-- Mark files with C-a, view marks with C-e
	use 'ThePrimeagen/harpoon'
	-- <Leader>u for undo history
	use 'mbbill/undotree'
	-- Git plugin, use :Git
	use 'tpope/vim-fugitive'
	-- :Gbrowse pulls up current file in Github
	use 'tpope/vim-rhubarb'
	-- Sets up LSP, autocompletion, and mason lsp manager
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		requires = {
			--- Uncomment these if you want to manage LSP servers from neovim
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- LSP Support
			{'neovim/nvim-lspconfig'},
			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'L3MON4D3/LuaSnip'},
		}
	}
	-- Shows next available keys
	use "folke/which-key.nvim"
	-- "gc" to comment visual regions/lines
	use "numToStr/Comment.nvim"
    -- Shows indentation as a vertical line
	use "lukas-reineke/indent-blankline.nvim"
    -- shows git signs in the gutter
    use "lewis6991/gitsigns.nvim"
    -- Allow formatters to be used as lsps
    use "nvimtools/none-ls.nvim"
    -- Status line
    use 'nvim-lualine/lualine.nvim'
end)
