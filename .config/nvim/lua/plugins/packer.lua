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
		tag = "0.1.x",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	-- Colorscheme
	use("navarasu/onedark.nvim")
	use("folke/tokyonight.nvim")
	-- Abstract syntax tree support
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	-- Mark files with C-a, view marks with C-e
	use({
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	-- <Leader>u for undo history
	use("mbbill/undotree")
	-- Git plugin, use :Git
	use("tpope/vim-fugitive")
	-- :Gbrowse pulls up current file in Github
	use("tpope/vim-rhubarb")
	-- Sets up LSP, autocompletion, and mason lsp manager
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		requires = {
			--- Uncomment these if you want to manage LSP servers from neovim
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "L3MON4D3/LuaSnip" },
		},
	})
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
	use({ "https://github.com/apple/pkl-neovim", after = "nvim-treesitter", run = ":TSInstall! pkl" })
	-- Testing support
	use({
		"nvim-neotest/neotest",
		requires = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"ehmurray8/neotest-swift",
		},
	})
	-- File explorer
	use("stevearc/oil.nvim")
	-- Debugging support
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } })
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
    use{
        "Joakker/lua-json5",
        run = "./install.sh"
    }
	use({ "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } })
    use("theHamsta/nvim-dap-virtual-text")
    use("jay-babu/mason-nvim-dap.nvim")
    use("grafana/vim-alloy")
end)
