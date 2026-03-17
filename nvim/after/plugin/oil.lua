require("oil").setup({})

vim.keymap.set("n", "<leader>-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>pv", "<CMD>Oil --float .<CR>", { desc = "View file explorer" })

