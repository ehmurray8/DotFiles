local ft = require("guard.filetype")
local filetype = require("plenary.filetype")

local function is_executable(cmd)
	return vim.fn.executable(cmd) == 1
end

if is_executable("lsp") and is_executable("stylua") and is_executable("selene") then
    ft("lua"):fmt("lsp"):append("stylua"):lint("selene")
end


ft("typescript,javascript,typescriptreact,javascriptreact,vue,yaml"):fmt("prettier")

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
