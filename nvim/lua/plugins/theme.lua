local omarchy = require("config.omarchy_theme")
local omarchy_specs = omarchy.normalize_specs()

if omarchy_specs then
	return omarchy_specs
end

return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			on_highlights = function(highlights)
				highlights.DapBreakpoint = { fg = "#f73939" }
				highlights.DapBreakpointRejected = { fg = "#dbdb02" }
				highlights.DapStopped = { fg = "#228b22" }
			end,
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd.colorscheme("tokyonight-moon")
		end,
	},
}
