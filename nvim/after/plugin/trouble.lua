require("trouble").setup({})

vim.keymap.set(
	"n",
	"<leader>qf",
	"<cmd>Trouble qflist toggle<cr>",
	{ silent = true, noremap = true, desc = "Quickfix List (Trouble)" }
)
