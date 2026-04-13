require("neotest").setup({
    log_level = vim.log.levels.DEBUG,
	adapters = {
		require("neotest-swift")({ }),
        require("neotest-python")
	},
    output = {
        enabled = true,
        open_on_run = false
    }
})
