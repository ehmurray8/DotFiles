local treesitter = require("nvim-treesitter")
treesitter.setup({})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"java",
		"c",
		"lua",
		"vim",
		"vimdoc",
		"query",
		"javascript",
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
		"svelte",
		"cs",
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
