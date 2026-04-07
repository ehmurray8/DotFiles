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
        "python",
        "vue",
        "html",
        "xml",
        "terraform",
        "css",
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
        "python",
        "terraform",
        "css",
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
