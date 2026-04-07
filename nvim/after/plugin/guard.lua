local ft = require("guard.filetype")
local filetype = require("plenary.filetype")
local lint = require("guard.lint")

local function is_executable(cmd)
	return vim.fn.executable(cmd) == 1
end

if is_executable("stylua") and is_executable("selene") then
	ft("lua"):fmt("stylua"):lint({
		cmd = "selene",
		args = { "--no-summary", "--display-style", "json2", "--globals", "vim", "-" },
		stdin = true,
		parse = lint.from_json({
			attributes = {
				lnum = function(offence)
					return offence.primary_label.span.start_line
				end,
				col = function(offence)
					return offence.primary_label.span.start_column
				end,
			},
			severities = {
				Error = lint.severities.error,
				Warning = lint.severities.warning,
			},
			lines = true,
			offset = 0,
			source = "selene",
		}),
	})
end

ft("xml"):fmt("xmllint")

ft("typescript,javascript,typescriptreact,javascriptreact,vue,yaml,css,html,yaml,markdown"):fmt("prettier")

if is_executable("swiftformat") then
	ft("swift"):fmt("swiftformat")
end

ft("json"):fmt({
	cmd = "jq",
	stdin = true,
	args = {
		"--indent",
		"4",
	},
})

filetype.add_table({
	extension = {
		["terraform"] = "terraform",
		["alloy"] = "alloy",
	},
})

if is_executable("terraform") then
	ft("terraform"):fmt({
		cmd = "terraform",
		stdin = true,
		args = {
			"fmt",
			"-",
		},
	})
end

if is_executable("alloy") then
	ft("alloy"):fmt({
		cmd = "alloy",
		stdin = true,
		args = {
			"fmt",
			"-",
		},
	})
end

-- Using ruff lsp for now
-- ft("python"):fmt("black"):lint("pylint")

if is_executable("ktlint") and is_executable("detekt") then
    ft("kotlin"):fmt("ktlint"):lint("detekt")
end

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
