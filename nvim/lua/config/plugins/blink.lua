local blink = require("blink.cmp")

blink.setup({
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 200 },
		menu = {
			draw = {
				treesitter = { "lsp" },
			},
		},
	},
	snippets = { preset = "default" },
	sources = {
		compat = { "dadbod" },
		default = { "lsp", "path", "snippets", "buffer" },
		per_filetype = {
			lua = { "lsp", "path", "snippets", "buffer", "lazydev" },
			sql = { "dadbod", "buffer" },
			mysql = { "dadbod", "buffer" },
			plsql = { "dadbod", "buffer" },
		},
		providers = {
			dadbod = {
				name = "Dadbod",
				module = "blink.compat.source",
			},
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				score_offset = 100,
			},
		},
	},
	keymap = {
		preset = "enter",
		["<C-p>"] = { "select_prev", "fallback" },
		["<C-n>"] = { "select_next", "fallback" },
		["<C-y>"] = { "select_and_accept" },
		["<C-Space>"] = { "show", "fallback" },
	},
})
