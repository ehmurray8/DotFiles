local lsp_zero = require("lsp-zero")
local util = require("lspconfig.util")

-- lsp_zero.format_on_save({
--   format_opts = {
--     async = false,
--     timeout_ms = 10000,
--   },
--   servers = {
--     ['rust_analyzer'] = {'rust'},
--     ['null-ls'] = {'javascript', 'typescript', 'vue'},
--     ['gopls'] = { 'go' },
--     ['lua_ls'] = { 'lua' },
--   }
-- })

local function quickfix()
	vim.lsp.buf.code_action({
		filter = function(a)
			return a.isPreferred
		end,
		apply = true,
	})
end

vim.keymap.set("n", "<leader>qf", quickfix, { noremap = true, silent = true })

lsp_zero.on_attach(function(client, bufnr)
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
	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end, { buffer = bufnr, remap = false, desc = "View diagnostics" })
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, { buffer = bufnr, remap = false, desc = "Next diagnostic" })
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, { buffer = bufnr, remap = false, desc = "Previous diagnostic" })
	vim.keymap.set("n", "<leader>vca", function()
		vim.lsp.buf.code_action()
	end, { buffer = bufnr, remap = false, desc = "View code actions" })
	vim.keymap.set("n", "<leader>vrn", function()
		vim.lsp.buf.rename()
	end, { buffer = bufnr, remap = false, desc = "LSP Rename" })
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, { buffer = bufnr, remap = false, desc = "Signature help" })
end)

vim.filetype.add({
	extension = {
		pkl = "pkl",
	},
})

local pkl_lsp_config = {
	default_config = {
		cmd = { "pkl-lsp-server" },
		filetypes = { "pkl" },
		root_dir = function(filename, _)
			return util.root_pattern(".git", "Package.swift")(filename) or util.find_git_ancestor(filename)
		end,
		settings = {},
	},
	docs = {
		description = [[
https://github.com/jayadamsmorgan/PklLanguageServer

Language server for PKL.
    ]],
	},
}

require("lspconfig.configs").pkl_lsp = pkl_lsp_config

require("mason").setup({})
require("mason-lspconfig").setup({
	automatic_installation = false,
	ensure_installed = {},
	handlers = {
		lsp_zero.default_setup,
		lua_ls = function()
			local lua_opts = lsp_zero.nvim_lua_ls()
			table.insert(
				lua_opts.settings.Lua.workspace.library,
				"/Users/emmet/.local/share/nvim/site/pack/packer/start/neotest/lua/"
			)
			local mason_registry = require("mason-registry")
			local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup(lua_opts)
			lspconfig.sourcekit.setup({
				capabilities = {
					workspace = {
						didChangeWatchedFiles = {
							dynamicRegistration = true,
						},
					},
				},
			})
			lspconfig.pkl_lsp.setup({
				capabilities = {
					workspace = {
						didChangeWatchedFiles = {
							dynamicRegistration = true,
						},
					},
				},
			})
			lspconfig.volar.setup({
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
				init_options = {
					vue = {
						hybridMode = false,
					},
				},
			})
			lspconfig.tailwindcss.setup({})
			lspconfig.eslint.setup({})
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			lspconfig.cssls.setup({
				capabilities = capabilities,
			})
			lspconfig.bashls.setup({})
			lspconfig.gopls.setup({})
			lspconfig.terraformls.setup{}
		end,
	},
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
	},
	formatting = lsp_zero.cmp_format(),
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
})

cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
	sources = {
		{ name = "vim-dadbod-completion" },
		{ name = "buffer" },
	},
})
