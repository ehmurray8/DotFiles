require("tokyonight").setup({
	on_highlights = function(highlights, colors)
        highlights.DapBreakpoint ={
            fg = "#f73939"
        }
        highlights.DapBreakpointRejected = {
            fg = "#dbdb02"
        }
        highlights.DapStopped = {
            fg = "#228b22"
        }
	end,
})
