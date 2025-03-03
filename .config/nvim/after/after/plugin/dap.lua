local dap = require("dap")

local dapui = require("dapui")
dapui.setup()

-- Automatically attach and detach from DAPUI
dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

local libLLDB = "/Applications/Xcode.app/Contents/SharedFrameworks/LLDB.framework/Versions/A/LLDB"

dap.adapters.swift = {
	type = "server",
	port = "${port}",
	executable = {
		command = "/Users/emmet/.local/share/nvim/mason/bin/codelldb",
		args = { "--liblldb", libLLDB, "--port", "${port}" },
	},
}

dap.configurations.swift = {
	{
		name = "Launch file",
		type = "swift",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}

dap.configurations.swift = {
	{
		name = "Launch Vapor",
		type = "swift",
		request = "launch",
		program = {},
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}

local js_languages = {
	"typescript",
	"javascript",
	"typescriptreact",
	"javascriptreact",
	"vue",
}

for _, language in ipairs(js_languages) do
	dap.configurations[language] = {
		-- Debug single nodejs files
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
		},
		-- Debug nodejs processes (make sure to add --inspect when you run the process)
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = require("dap.utils").pick_process,
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
		},
		-- Debug web applications (client side)
		{
			type = "pwa-chrome",
			request = "launch",
			name = "Launch & Debug Chrome",
			url = function()
				local co = coroutine.running()
				return coroutine.create(function()
					vim.ui.input({
						prompt = "Enter URL: ",
						default = "http://localhost:3000",
					}, function(url)
						if url == nil or url == "" then
							return
						else
							coroutine.resume(co, url)
						end
					end)
				end)
			end,
			webRoot = vim.fn.getcwd(),
			protocol = "inspector",
			sourceMaps = true,
			userDataDir = false,
		},
		-- Auto attach to node processes running with `node --inspect`
		{
			type = "pwa-node",
			request = "attach",
			name = "Auto Attach",
			cwd = vim.fn.getcwd(),
			protocol = "inspector",
		},
		-- Divider for the launch.json derived configs
		{
			name = "----- ↓ launch.json configs ↓ -----",
			type = "",
			request = "launch",
		},
	}
end

require("dap-vscode-js").setup({})

vim.keymap.set("n", "<Leader>es", function()
	if vim.fn.filereadable(".vscode/launch.json") then
		local dap_vscode = require("dap.ext.vscode")
		dap_vscode.load_launchjs(nil, {
			["pwa-node"] = js_languages,
			["chrome"] = js_languages,
			["pwa-chrome"] = js_languages,
		})
	end
	require("dap").continue()
end, { desc = "Debug start" })

vim.fn.sign_define("DapBreakpoint", {
	text = "",
	texthl = "DapBreakpoint",
})
vim.fn.sign_define("DapBreakpointCondition", {
	text = "",
	texthl = "DapBreakpoint",
})
vim.fn.sign_define("DapBreakpointRejected", {
	text = "",
	texthl = "DapBreakpointRejected",
})
vim.fn.sign_define("DapLogPoint", {
	text = "",
	texthl = "DapLBreakpoint",
})
vim.fn.sign_define("DapStopped", {
	text = "",
	texthl = "DapStopped",
})
