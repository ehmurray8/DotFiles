require("neotest").setup({
	log_level = vim.log.levels.DEBUG,
	adapters = {
		require("neotest-swift")({}),
		require("neotest-python"),
	},
	output = {
		enabled = true,
		open_on_run = false,
	},
})

vim.keymap.set("n", "<leader>tr", function()
	require("neotest").run.run()
end, { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>tf", function()
	require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run all tests in file" })
vim.keymap.set("n", "<leader>tt", function()
	require("neotest").run.run({ suite = true, extra_args = { target = true } })
end, { desc = "Run all tests in target (swift)." })
vim.keymap.set("n", "<leader>ta", function()
	require("neotest").run.run({ suite = true })
end, { desc = "Run all tests in project" })
vim.keymap.set("n", "<leader>tw", function()
	require("neotest").watch.toggle()
end, { silent = true, desc = "Watch test" })
vim.keymap.set("n", "<leader>ts", function()
	require("neotest").summary.toggle()
end, { silent = true, desc = "Test summary" })
vim.keymap.set("n", "<leader>to", function()
	require("neotest").output.open({ short = true, enter = true })
end, { silent = true, desc = "Open test output" })
vim.keymap.set("n", "<leader>tp", function()
	require("neotest").output_panel.toggle()
end, { silent = true, desc = "Toggle test output pane" })
vim.keymap.set("n", "<leader>et", function()
	require("lazy").load({ plugins = { "nvim-dap-ui" } })
	require("neotest").run.run({ strategy = "dap" })
end, { desc = "Debug nearest test" })
