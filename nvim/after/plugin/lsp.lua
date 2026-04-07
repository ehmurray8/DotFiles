require("mason").setup({})

require("kotlin").setup({
	inlay_hints = {
		enabled = true,
	},
	-- Add this to pass options to the underlying LSP client
	lspconfig = {
		-- Increase the timeout for the initial handshake
		init_options = {
			storagePath = vim.fn.stdpath("cache") .. "/kotlin-lsp",
		},
		flags = {
			-- This prevents Neovim from spamming the "heavy" Kotlin server
			debounce_text_changes = 200,
		},
	},
	settings = {
		kotlin = {
			imports = {
				importAliasCount = 99,
				starImportLimit = 99,
			},
		},
	},
})

vim.lsp.handlers["textDocument/completion"] = function(err, result, ctx, config)
	return vim.lsp.handlers.on_completion(err, result, ctx, config)
end

local original_request = vim.lsp.buf_request
vim.lsp.buf_request = function(bufnr, method, params, handler)
	return original_request(bufnr, method, params, handler)
end

-- https://www.reddit.com/r/neovim/comments/1mbk9sk/comment/n5tougl/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1
require("mason-lspconfig").setup({
	ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
	automatic_installation = false,
	handlers = {
		function(server_name)
			local server = servers[server_name] or {}
			-- This handles overriding only values explicitly passed
			-- by the server configuration above. Useful when disabling
			-- certain features of an LSP (for example, turning off formatting for ts_ls)
			server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
			require("lspconfig")[server_name].setup(server)
		end,
	},
})

local vue_ls_path = vim.fn.expand("$MASON/packages/vue-language-server")
local vue_language_server_path = vue_ls_path .. "/node_modules/@vue/language-server"

vim.lsp.config("ts_ls", {
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = vue_language_server_path,
				languages = { "vue" },
			},
		},
	},
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})

vim.lsp.config("tailwindcss", {
	settings = {
		tailwindCSS = {
			classAttributes = {
				"class",
				"className",
				"class:list",
				"classList",
				"ngClass",
				"component-class",
				"parent-class",
				":component-class",
				":parent-class",
			},
		},
	},
})

vim.lsp.enable("tailwindcss")

local vue_plugin = {
	name = "@vue/typescript-plugin",
	location = vue_language_server_path,
	languages = { "vue" },
	configNamespace = "typescript",
}

vim.lsp.config("vtsls", {
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					vue_plugin,
				},
			},
		},
	},
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})

vim.lsp.config("jdtls", {
	filetypes = { "java" },
})

vim.lsp.config("vue_ls", {
	settings = {
		init_options = {
			typescript = {
				tsdk = "",
			},
		},
	},
	on_init = function(client)
		client.handlers["tsserver/request"] = function(_, result, context)
			local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
			if #clients == 0 then
				vim.notify(
					"Could not find `vtsls` lsp client, `vue_ls` would not work without it.",
					vim.log.levels.ERROR
				)
				return
			end
			local ts_client = clients[1]

			local param = unpack(result)
			local id, command, payload = unpack(param)
			ts_client:exec_cmd({
				title = "vue_request_forward", -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
				command = "typescript.tsserverRequest",
				arguments = {
					command,
					payload,
				},
			}, { bufnr = context.bufnr }, function(_, r)
				local response = r and r.body
				-- TODO: handle error or response nil here, e.g. logging
				-- NOTE: Do NOT return if there's an error or no response, just return nil back to the vue_ls to prevent memory leak
				local response_data = { { id, response } }

				---@diagnostic disable-next-line: param-type-mismatch
				client:notify("tsserver/response", response_data)
			end)
		end
	end,
})

vim.lsp.config("lua_ls", {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath("config")
				and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				version = "LuaJIT",
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
				},
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
		})
	end,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.config("*", {
	capabilities = capabilities,
})

local cmp = require("cmp")

cmp.setup({
	performance = {
		fetching_timeout = 2000, -- Increase the time cmp waits for a response
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
	},
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
	},
})

cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
	sources = {
		{ name = "vim-dadbod-completion" },
		{ name = "buffer" },
	},
})

vim.filetype.add({
	extension = {
		pkl = "pkl",
	},
})

local function quickfix()
	vim.lsp.buf.code_action({
		filter = function(a)
			return a.isPreferred
		end,
		apply = true,
	})
end

vim.diagnostic.config({ virtual_text = true })

vim.keymap.set("n", "<leader>qf", quickfix, { noremap = true, silent = true })

vim.keymap.set("n", "vd", "<cmd>lua vim.diagnostic.open_float()<cr>", { remap = false, desc = "View diagnostics" })
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { remap = false, desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", { remap = false, desc = "Next diagnostic" })

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local bufnr = event.buf
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, { buffer = bufnr, remap = false, desc = "Go to definition" })
		vim.keymap.set("n", "gr", function()
			require("telescope.builtin").lsp_references()
		end, { buffer = bufnr, remap = false, desc = "Go to references" })
		vim.keymap.set("n", "gh", function()
			vim.lsp.buf.document_highlight()
		end, { buffer = bufnr, remap = false, desc = "Go to highlight" })
		vim.keymap.set("n", "ghc", function()
			vim.lsp.buf.clear_references()
		end, { buffer = bufnr, remap = false, desc = "Go to highlight clear" })
		vim.keymap.set("n", "<leader>h", function()
			vim.lsp.buf.hover()
		end, { buffer = bufnr, remap = false, desc = "Hover help" })
		vim.keymap.set("n", "<leader>vws", function()
			vim.lsp.buf.workspace_symbol()
		end, { buffer = bufnr, remap = false, desc = "View workspace symbol" })
		vim.keymap.set("n", "<leader>vca", function()
			vim.lsp.buf.code_action()
		end, { buffer = bufnr, remap = false, desc = "View code actions" })
		vim.keymap.set("n", "<leader>vrn", function()
			vim.lsp.buf.rename()
		end, { buffer = bufnr, remap = false, desc = "LSP Rename" })
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, { buffer = bufnr, remap = false, desc = "Signature help" })
		vim.keymap.set("n", "<leader>oi", function()
			vim.lsp.buf.code_action({
				context = { only = { "source.organizeImports" }, diagnostics = {} },
				apply = true,
			})
		end, { buffer = event.buf, desc = "Optimize Imports" })

		-- local client = vim.lsp.get_client_by_id(event.data.client_id)
		-- if client:supports_method("textDocument/completion") then
		-- 	vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
		-- end
	end,
})

vim.lsp.enable("vtsls")
vim.lsp.enable("vue_ls")
vim.lsp.enable("cssls")
vim.lsp.enable("bashls")
vim.lsp.enable("terraformls")
vim.lsp.enable("gopls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("eslint")
vim.lsp.enable("ts_ls")
vim.lsp.enable("sourcekit") -- swift
vim.lsp.enable("kotlin")
