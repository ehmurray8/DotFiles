-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim")
	-- Fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
        version="*",
		requires = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
	})
	-- Colorscheme
	use("navarasu/onedark.nvim")
	use("folke/tokyonight.nvim")
	-- Abstract syntax tree support
	use({
		"nvim-treesitter/nvim-treesitter",
        branch = "main",
		run = ":TSUpdate",
	})
	-- Git plugin, use :Git
	use("tpope/vim-fugitive")
	-- :Gbrowse pulls up current file in Github
	use("tpope/vim-rhubarb")
	-- Sets up LSP, autocompletion, and mason lsp manager
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("neovim/nvim-lspconfig")
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"L3MON4D3/LuaSnip",
		},
	})

	-- use({
	--     "saghen/blink.cmp",
	--     dependencies = { 'rafamadriz/friendly-snippets' },
	-- })

	-- Shows next available keys
	use("folke/which-key.nvim")
	-- 'gc' to comment visual regions/lines
	use("numToStr/Comment.nvim")
	-- Shows indentation as a vertical line
	use("lukas-reineke/indent-blankline.nvim")
	-- shows git signs in the gutter
	use("lewis6991/gitsigns.nvim")
	-- Status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = false },
	})
	-- Auto switch light/dark theme
	use("f-person/auto-dark-mode.nvim")
	-- Linting/Formatting support
	use("nvimdev/guard-collection")
	use({
		"nvimdev/guard.nvim",
		requires = {
			{ "nvimdev/guard-collection" },
		},
	})
	-- Pkl syntax highlighting
	use({ "apple/pkl-neovim", after = "nvim-treesitter", run = ":TSInstall! pkl" })
	-- Testing support
	use({
		"nvim-neotest/neotest",
		requires = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
            "nvim-neotest/neotest-python",
			"ehmurray8/neotest-swift",
		},
	})
	-- File explorer
	use("stevearc/oil.nvim")
	-- Debugging support
	use({
		"rcarriga/nvim-dap-ui",
		requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "wojciech-kulik/xcodebuild.nvim" },
	})
	-- SQL Support
	use({
		"kristijanhusak/vim-dadbod-ui",
		requires = {
			use("tpope/vim-dadbod"),
			use("kristijanhusak/vim-dadbod-completion"),
		},
	})
	use({
		"microsoft/vscode-js-debug",
		opt = true,
		run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
	})
	use({
		"Joakker/lua-json5",
		run = "./install.sh",
	})
	use({ "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } })
	use("theHamsta/nvim-dap-virtual-text")
	use("jay-babu/mason-nvim-dap.nvim")
	use("grafana/vim-alloy")
	use("rushjs1/nuxt-goto.nvim")

	use({ "wojciech-kulik/xcodebuild.nvim", requires = { "MunifTanjim/nui.nvim", "wojciech-kulik/snacks.nvim" } })
	use("folke/trouble.nvim")

	use("Bishop-Fox/colorblocks.nvim")

	use("AlexandrosAlexiou/kotlin.nvim")
end)
