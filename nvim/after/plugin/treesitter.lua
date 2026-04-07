-- require("nvim-treesitter.install").prefer_git = true

-- require("nvim-treesitter.config").setup({
-- 	-- A list of parser names, or "all" (the five listed parsers should always be installed)
-- 	ensure_installed = {
-- 		"c",
-- 		"lua",
-- 		"vim",
-- 		"vimdoc",
-- 		"query",
-- 		"javascript",
-- 		"typescript",
-- 		"java",
-- 		"kotlin",
-- 		"sql",
-- 		"swift",
-- 		"pkl",
-- 	},
--
-- 	-- Install parsers synchronously (only applied to `ensure_installed`)
-- 	sync_install = false,
--
-- 	-- Automatically install missing parsers when entering buffer
-- 	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
-- 	auto_install = true,
--
-- 	highlight = {
-- 		enable = true,
--
-- 		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
-- 		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
-- 		-- Using this option may slow down your editor, and you may see some duplicate highlights.
-- 		-- Instead of true it can also be a list of languages
-- 		additional_vim_regex_highlighting = false,
-- 	},
-- 	playground = {
-- 		enable = true,
-- 		disable = {},
-- 		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
-- 		persist_queries = false, -- Whether the query persists across vim sessions
-- 		keybindings = {
-- 			toggle_query_editor = "o",
-- 			toggle_hl_groups = "i",
-- 			toggle_injected_languages = "t",
-- 			toggle_anonymous_nodes = "a",
-- 			toggle_language_display = "I",
-- 			focus_language = "f",
-- 			unfocus_language = "F",
-- 			update = "R",
-- 			goto_node = "<cr>",
-- 			show_help = "?",
-- 		},
-- 	},
-- })

local treesitter = require("nvim-treesitter")
treesitter.setup({
	ensure_installed = {
		"c",
		"lua",
		"vim",
		"vimdoc",
		"query",
		"javascript",
		"typescript",
		"java",
		"kotlin",
		"sql",
		"swift",
		"pkl",
	},
    prefer_git = true,
    highlight = {
        enable = true
    },
    indent = {
        enable = true
    },
    auto_install = true,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"java",
		"c",
		"lua",
		"vim",
		"vimdoc",
		"query",
		"javasjript",
		"typescript",
		"html",
		"yaml",
		"sql",
		"swift",
		"kotlin",
        "javascriptreact",
        "typescriptreact",
        "vue",
	},
	callback = function()
		-- syntax highlighting, provided by Neovim
		vim.treesitter.start()
		-- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		-- vim.wo.foldmethod = "expr"
		-- indentation, provided by nvim-treesitter
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
