local ft = require("guard.filetype")
local filetype = require("plenary.filetype")

ft("lua"):fmt("lsp"):append("stylua"):lint("selene")

ft("typescript,javascript,typescriptreact,javascriptreact,vue,yaml"):fmt("prettier")
ft("swift"):fmt("swiftformat")
ft("json"):fmt({
	cmd = "jq",
	stdin = true,
	args = {
		"--indent",
		"4",
	},
})

if filetype.detect_from_extension("swift") == "" then
	filetype.add_table({
		extension = {
			["terraform"] = "terraform",
			["alloy"] = "alloy",
		},
	})
end

ft("terraform"):fmt({
	cmd = "terraform",
	stdin = true,
	args = {
		"fmt",
		"-",
	},
})

ft("alloy"):fmt({
	cmd = "alloy",
	stdin = true,
	args = {
		"fmt",
		"-",
	},
})

ft("python"):fmt("black"):lint("pylint")

-- NB: this does not work with formatters
ft("*"):lint("codespell")

vim.g.guard_config = {
	-- Choose to format on every write to a buffer
	fmt_on_save = false,
	-- Use lsp if no formatter was defined for this filetype
	lsp_as_default_formatter = false,
	-- By default, Guard writes the buffer on every format
	-- You can disable this by setting:
	-- save_on_fmt = false,
}
