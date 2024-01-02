-- Set leader as <space>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "View file explorer" })

-- Move lines up and down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected line down" })
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv", { desc = "Move selected line up"  })

-- Ctrl + d, Ctrl + u half page scrolling keep cursor in place
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page scroll down" } )
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page scroll up" })

-- When going to next or previous search term keep cursor in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- leader p to paste without losing current paste register
vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Paste wihtout losing current paste register" })

vim.keymap.set("n", "<leader>y", "\"+y", { desc = "Copy to the system clipboard" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "Copy to the system clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+y", { desc = "Copy to the system clipboard" })

vim.keymap.set("n", "<leader>d", "\"_d", { desc = "Delete without clearing current paste register" })
vim.keymap.set("v", "<leader>d", "\"_d", { desc = "Delete without clearing current paste register" })

-- Don't quit when pressing Q
vim.keymap.set("n", "Q", "<nop>")

-- TODO: Why doesn't this work?
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.scripts/tmux-sessionizer<CR>")

vim.keymap.set("n", "<leader>fc", function()
    vim.lsp.buf.format()
end, { desc = "Format Code" })

-- Replace current word with leader s
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make the current file executable with leader x
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make current file executable" })

vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame" })
