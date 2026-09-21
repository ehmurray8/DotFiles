local M = {}

M.theme_file = vim.fn.expand("~/.local/state/omarchy/current/theme/neovim.lua")

function M.is_omarchy()
	return vim.fn.isdirectory("/usr/share/omarchy") == 1
end

function M.load_specs()
	if not M.is_omarchy() or vim.fn.filereadable(M.theme_file) ~= 1 then
		return nil
	end

	local ok, specs = pcall(dofile, M.theme_file)
	if ok and type(specs) == "table" then
		return specs
	end

	return nil
end

function M.current_theme()
	local specs = M.load_specs()
	if not specs then
		return nil, nil
	end

	local theme_plugin
	local colorscheme
	for _, spec in ipairs(specs) do
		if spec[1] == "LazyVim/LazyVim" then
			colorscheme = spec.opts and spec.opts.colorscheme
		elseif spec[1] then
			theme_plugin = spec.name or spec[1]
		end
	end

	return theme_plugin, colorscheme
end

function M.normalize_specs()
	local specs = M.load_specs()
	if not specs then
		return nil
	end

	local normalized = {}
	local theme_plugin, colorscheme = M.current_theme()
	for _, spec in ipairs(specs) do
		if spec[1] ~= "LazyVim/LazyVim" then
			table.insert(normalized, spec)
		end
	end

	if theme_plugin and colorscheme then
		table.insert(normalized, {
			name = "dotfiles-omarchy-theme",
			dir = vim.fn.stdpath("config"),
			lazy = false,
			priority = 999,
			dependencies = { theme_plugin },
			config = function()
				pcall(vim.cmd.colorscheme, colorscheme)
			end,
		})
	end

	return normalized
end

function M.watch()
	if not M.is_omarchy() then
		return
	end

	local watcher = vim.uv.new_fs_event()
	if not watcher then
		return
	end

	local current_dir = vim.fn.fnamemodify(M.theme_file, ":h:h")
	if vim.fn.isdirectory(current_dir) ~= 1 then
		return
	end
	local reload_pending = false
	vim.api.nvim_create_autocmd("User", {
		pattern = "LazyReload",
		callback = function()
			local plugin_name, colorscheme = M.current_theme()
			if not plugin_name or not colorscheme then
				return
			end

			vim.cmd("highlight clear")
			if vim.fn.exists("syntax_on") == 1 then
				vim.cmd("syntax reset")
			end
			vim.o.background = "dark"

			local config = require("lazy.core.config")
			local loader = require("lazy.core.loader")
			local plugin = config.plugins[plugin_name]
			if plugin then
				if plugin._.loaded then
					loader.reload(plugin)
				else
					loader.load(plugin, { start = "omarchy theme" })
				end
			end

			vim.schedule(function()
				pcall(vim.cmd.colorscheme, colorscheme)
				vim.cmd("redraw!")
			end)
		end,
	})

	watcher:start(current_dir, {}, function()
		if reload_pending then
			return
		end
		reload_pending = true
		vim.schedule(function()
			vim.defer_fn(function()
				reload_pending = false
				if vim.fn.filereadable(M.theme_file) == 1 then
					require("lazy.manage.reloader").reload({
						{ file = M.theme_file, what = "Omarchy theme" },
					})
				end
			end, 100)
		end)
	end)

	vim.api.nvim_create_autocmd("VimLeavePre", {
		callback = function()
			if not watcher:is_closing() then
				watcher:stop()
				watcher:close()
			end
		end,
	})
end

return M
