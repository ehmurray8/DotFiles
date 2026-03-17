require("neotest").setup({
    log_level = vim.log.levels.DEBUG,
	adapters = {
		require("neotest-swift")({ }),
	},
    output = {
        enabled = true,
        open_on_run = false
    }
})
