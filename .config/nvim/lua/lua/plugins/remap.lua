-- Set leader as <space>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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

vim.keymap.set("n", "<leader>fc", ":Guard fmt<CR>", { desc = "Format code" })
vim.keymap.set("n", "<leader>fd", ":Guard disable<CR>", { desc = "Disable Guard" })
vim.keymap.set("n", "<leader>fe", ":Guard disable<CR>", { desc = "Enable Guard" })
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

-- Neotest
vim.keymap.set("n", "<Leader>tr", function()
	require("neotest").run.run()
end, { desc = "Run nearest test" })
vim.keymap.set("n", "<Leader>tf", function()
	require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run all tests in file" })
vim.keymap.set("n", "<Leader>tt", function()
	require("neotest").run.run({ suite = true, extra_args = { target = true } })
end, { desc = "Run all tests in target (swift)." })
vim.keymap.set("n", "<Leader>ta", function()
	require("neotest").run.run({ suite = true })
end, { desc = "Run all tests in project" })
vim.keymap.set("n", "<Leader>tw", function()
	require("neotest").watch.toggle()
end, { silent = true, desc = "Watch test" })
vim.keymap.set("n", "<Leader>ts", function()
	require("neotest").summary.toggle()
end, { silent = true, desc = "Test summary" })
vim.keymap.set("n", "<Leader>to", function()
	require("neotest").output.open({ short = true, enter = true })
end, { silent = true, desc = "Open test output" })
vim.keymap.set("n", "<Leader>tp", function()
	require("neotest").output_panel.toggle()
end, { silent = true, desc = "Toggle test output pane" })

-- nvim-dap
vim.keymap.set("n", "<Leader>et", function()
	require("neotest").run.run({ strategy = "dap" })
end, { desc = "Debug nearest test" })
vim.keymap.set("n", "<Leader>eb", function()
	require("dap").toggle_breakpoint()
end, { desc = "Debug set breakpoint" })
vim.keymap.set("v", "<leader>ee", function()
	require("dapui").eval()
end, { desc = "Debug evaluate" })
vim.keymap.set("n", "<Leader>ec", function()
	require("dap").continue()
end, { desc = "Debug continue" })
vim.keymap.set("n", "<Leader>eo", function()
	require("dap").step_over()
end, { desc = "Debug step over" })
vim.keymap.set("n", "<Leader>ei", function()
	require("dap").step_into()
end, { desc = "Debug step into" })
vim.keymap.set("n", "<Leader>eO", function()
	require("dap").step_out()
end, { desc = "Debug step out" })

vim.api.nvim_create_user_command("DAPUI", function()
	require("dapui").toggle()
end, { desc = "Open DAPUI" })
