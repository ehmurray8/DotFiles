require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "tokyonight",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
            "branch",
			"diff",
			"diagnostics",
		},
		lualine_c = { { "filename", file_status = false, separator = "", path=1 }, { "filetype", icon_only = true } },
		lualine_x = { "searchcount" },
		lualine_y = { "location" },
		lualine_z = { "progress" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { },
		lualine_y = { "location" },
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
