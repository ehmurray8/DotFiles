local treesitter_parsers = {
	"c",
	"css",
	"html",
	"java",
	"javascript",
	"kotlin",
	"lua",
	"python",
	"query",
	"sql",
	"swift",
	"terraform",
	"typescript",
	"vim",
	"vimdoc",
	"vue",
	"xml",
}

return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			on_highlights = function(highlights)
				highlights.DapBreakpoint = { fg = "#f73939" }
				highlights.DapBreakpointRejected = { fg = "#dbdb02" }
				highlights.DapStopped = { fg = "#228b22" }
			end,
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd.colorscheme("tokyonight-moon")
		end,
	},
	{
		"f-person/auto-dark-mode.nvim",
		event = "VeryLazy",
		config = function()
			require("config.plugins.auto-dark-mode")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = function()
			local treesitter = require("nvim-treesitter")
			treesitter.update():wait(300000)
			treesitter.install(treesitter_parsers):wait(300000)
		end,
		config = function()
			require("config.plugins.treesitter")
		end,
	},
	{
		"mason-org/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate", "MasonLog" },
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		cmd = { "LspInstall", "LspUninstall" },
		dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
		opts = {
			ensure_installed = {},
			automatic_enable = false,
		},
	},
	{
		"nvim-flutter/flutter-tools.nvim",
		event = { { event = { "BufReadPre", "BufNewFile" }, pattern = { "*.dart", "pubspec.yaml" } } },
		dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
		opts = {
			fvm = true,
			widget_guides = { enabled = true },
		},
	},
	{
		"AlexandrosAlexiou/kotlin.nvim",
		ft = "kotlin",
		cmd = {
			"KotlinCleanWorkspace",
			"KotlinCodeActions",
			"KotlinDebug",
			"KotlinExportWorkspaceToJson",
			"KotlinFormat",
			"KotlinImplementation",
			"KotlinIncomingCalls",
			"KotlinInlayHintsToggle",
			"KotlinNewFromTemplate",
			"KotlinOrganizeImports",
			"KotlinOutgoingCalls",
			"KotlinQuickFix",
			"KotlinReferences",
			"KotlinRename",
			"KotlinShowLogs",
			"KotlinSymbols",
			"KotlinTypeDefinition",
			"KotlinWorkspaceSymbols",
		},
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			inlay_hints = { enabled = true },
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			require("config.plugins.lsp")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			require("config.plugins.cmp")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		cmd = { "Telescope", "LiveGrepGitRoot" },
		keys = { "<leader>pf", "<leader>gf", "<leader>sf", "<leader>ps", "<leader>sr" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			require("config.plugins.telescope")
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		cmd = "DAPUI",
		keys = {
			"<leader>eb",
			{ "<leader>ee", mode = "x" },
			"<leader>ec",
			"<leader>eo",
			"<leader>ei",
			"<leader>eO",
			"<leader>es",
			"<leader>xd",
			"<leader>xr",
			"<leader>xdt",
			"<leader>xdT",
			"<leader>xb",
			"<leader>xB",
			"<leader>xdx",
		},
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
			"wojciech-kulik/xcodebuild.nvim",
			{
				"microsoft/vscode-js-debug",
				build = "npm ci --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
			},
			{ "Joakker/lua-json5", build = "./install.sh" },
			"mxsdev/nvim-dap-vscode-js",
			"theHamsta/nvim-dap-virtual-text",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			require("config.plugins.dap")
		end,
	},
	{
		"nvim-neotest/neotest",
		keys = {
			"<leader>tr",
			"<leader>tf",
			"<leader>tt",
			"<leader>ta",
			"<leader>tw",
			"<leader>ts",
			"<leader>to",
			"<leader>tp",
			"<leader>et",
		},
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-python",
			"ehmurray8/neotest-swift",
		},
		config = function()
			require("config.plugins.neotest")
		end,
	},
	{
		"nvimdev/guard.nvim",
		event = { "BufReadPost", "BufNewFile" },
		cmd = "Guard",
		keys = {
			{ "<leader>fc", "<cmd>Guard fmt<cr>", desc = "Format code" },
			{ "<leader>fd", "<cmd>Guard disable-fmt<cr>", desc = "Disable Guard formatting" },
			{ "<leader>fe", "<cmd>Guard enable-fmt<cr>", desc = "Enable Guard formatting" },
		},
		dependencies = { "nvimdev/guard-collection", "nvim-lua/plenary.nvim" },
		config = function()
			require("config.plugins.guard")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{ "filename", file_status = false, separator = "", path = 1 },
					{ "filetype", icon_only = true },
				},
				lualine_x = { "searchcount" },
				lualine_y = { "location" },
				lualine_z = { "progress" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = {},
				lualine_y = { "location" },
				lualine_z = {},
			},
			tabline = {},
			extensions = {},
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
		opts = {},
	},
	{
		"numToStr/Comment.nvim",
		keys = {
			{ "gc", mode = { "n", "x" } },
			{ "gb", mode = { "n", "x" } },
		},
		opts = {},
	},
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", event = { "BufReadPost", "BufNewFile" }, opts = {} },
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("config.plugins.gitsigns")
		end,
	},
	{
		"stevearc/oil.nvim",
		cmd = "Oil",
		keys = {
			{ "<leader>-", "<cmd>Oil<cr>", desc = "Open parent directory" },
			{ "<leader>pv", "<cmd>Oil --float .<cr>", desc = "View file explorer" },
		},
		opts = {},
	},
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		keys = {
			{ "<leader>qf", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
		},
		opts = {},
	},
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G", "GBrowse" },
		keys = { { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" } },
		dependencies = { "tpope/vim-rhubarb" },
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		cmd = { "DB", "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
		ft = { "sql", "mysql", "plsql" },
		dependencies = { "tpope/vim-dadbod", "kristijanhusak/vim-dadbod-completion" },
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_icons = {
				expanded = {
					db = "▾ 󰆼",
					buffers = "▾ ",
					saved_queries = "▾ ",
					schemas = "▾ ",
					schema = "▾ 󰙅",
					tables = "▾ 󰓱",
					table = "▾ ",
				},
				collapsed = {
					db = "▸ 󰆼",
					buffers = "▸ ",
					saved_queries = "▸ ",
					schemas = "▸ ",
					schema = "▸ 󰙅",
					tables = "▸ 󰓱",
					table = "▸ ",
				},
				saved_query = "",
				new_query = "󰓰",
				tables = "󰓫",
				buffers = "󰉇",
				add_connection = "󰆺",
				connection_ok = "✓",
				connection_error = "✕",
			}
		end,
	},
	{ "grafana/vim-alloy", ft = "alloy" },
	{ "rushjs1/nuxt-goto.nvim", ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" } },
	{
		"Bishop-Fox/colorblocks.nvim",
		ft = { "lua", "css" },
		opts = {
			symbol = "v󱡕",
			virt_text_pos = "eol",
			mode = "fg",
			section = { "S", "  ", "The color is: ", "H" },
			filetypes = { "lua", "css" },
		},
	},
	{ "yousefhadder/markdown-plus.nvim", ft = "markdown", opts = {} },
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = "markdown",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	{
		"declancm/maximize.nvim",
		keys = {
			{
				"<leader>z",
				function()
					require("maximize").toggle()
				end,
				desc = "Toggle window zoom",
			},
		},
		opts = {},
	},
}
