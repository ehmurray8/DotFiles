-- Set leader as <space>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.api.nvim_create_user_command("LspInfo", "checkhealth vim.lsp", { desc = "Show LSP status" })

-- Move lines up and down in visual mode
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv", { desc = "Move selected line up" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected line down" })

-- Ctrl + d, Ctrl + u half page scrolling keep cursor in place
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page scroll down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page scroll up" })

-- When going to next or previous search term keep cursor in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- leader p to paste without losing current paste register
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste wihtout losing current paste register" })

vim.keymap.set("n", "<leader>y", '"+y', { desc = "Copy to the system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy to the system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+y', { desc = "Copy to the system clipboard" })

vim.keymap.set("n", "<leader>d", '"_d', { desc = "Delete without clearing current paste register" })
vim.keymap.set("v", "<leader>d", '"_d', { desc = "Delete without clearing current paste register" })

-- Don't quit when pressing Q
vim.keymap.set("n", "Q", "<nop>")

-- TODO: Why doesn't this work?
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.scripts/tmux-sessionizer<CR>")

vim.keymap.set("n", "<leader>ld", function()
	vim.diagnostic.config({ virtual_text = false })
end, { desc = "Disable LSP diagnostics" })
vim.keymap.set("n", "<leader>le", function()
	vim.diagnostic.config({ virtual_text = false })
end, { desc = "Enable LSP diagnostics" })

-- Replace current word with leader s
vim.keymap.set(
	"n",
	"<leader>r",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace the current word" }
)

-- Make the current file executable with leader x
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make current file executable" })

vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame" })

-- Insert mode: <Leader>cu inserts a trimmed UUID
vim.keymap.set("n", "<Leader>cu", function()
	return string.lower(vim.fn.trim(vim.fn.system("uuidgen")))
end, { expr = true, desc = "Insert UUID (insert mode)" })

-- Normal mode: <Leader>cu inserts a trimmed UUID and returns to normal mode
vim.keymap.set("n", "<Leader>cu", function()
	return string.lower("i" .. vim.fn.trim(vim.fn.system("uuidgen")))
end, { expr = true, desc = "Insert UUID (normal mode)" })

vim.keymap.set("v", "<Leader>cu", function()
	local uuid = string.lower(vim.fn.trim(vim.fn.system("uuidgen")))
	-- Replace visual selection with the UUID
	vim.api.nvim_feedkeys(uuid, "c", false)
end, { desc = "Replace selection with lowercase UUID" })
