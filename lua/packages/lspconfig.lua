local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local nvim_lsp = require("lspconfig")

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = { "documentation", "detail", "additionalTextEdits" },
}

capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

mason.setup({
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗",
		},
	},
})
-- auto install LSP List
mason_lspconfig.setup({
	auto_install = true,
	ensure_installed = {
		"lua_ls", -- lua language server
		"pylsp", -- python language server
	},
})
-- auto server setup
mason_lspconfig.setup_handlers({
	function(server_name)
		nvim_lsp[server_name].setup({
			capabilities = capabilities,
		})
	end,
})
-- Lua long Lsp Config
nvim_lsp.lua_ls.setup({
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
			diagnostics = {
				enable = true,
				globals = { "vim" },
				underline = true, -- underline errors/warnings in the code
				severity_sort = true, -- sort errors/warnings by severity
				signs = true, -- add signs in the gutter for errors/warnings
			},
            workspace = { checkThirdParty = false },
		},
	},
	capabilities = capabilities,
})

nvim_lsp.html.setup({
	capabilities = capabilities,
})

nvim_lsp.cssls.setup({
	capabilities = capabilities,
})

-- pyls normal python lsp
nvim_lsp.pylsp.setup({
	cmd = { "pylsp" },
	filetypes = { "python" },
	root_dir = nvim_lsp.util.root_pattern(".git", "venv", ".env", "main.py"),
	settings = {
		pylsp = {
			plugins = {
				pylsp_mypy = { enabled = true },
				pylsp_black = { enabled = true },
				pylsp_isort = { enabled = true },
				-- disabled standard plugins
				autopep8 = { enabled = false }, -- covered by black
				yapf = { enabled = false }, -- covered by black
				pycodestyle = { enabled = false },
				pydocstyle = { enabled = false },
			},
		},
	},
	capabilities = capabilities,
	single_file_support = true,
})

-- Set logging level for LSP messages
vim.lsp.set_log_level("debug")
