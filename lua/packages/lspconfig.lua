local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local nvim_lsp = require("lspconfig")

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- The following example advertise capabilities to `clangd`.
nvim_lsp.clangd.setup({
	capabilities = capabilities,
})

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
		"bashls",
		"rust_analyzer", -- rust language server
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
		},
	},
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
	single_file_support = true,
})
-- rust lsp config
nvim_lsp.rust_analyzer.setup({
	cmd = { "rust_analyzer" },
	filetypes = { "rust" },
	root_dir = nvim_lsp.util.root_pattern("Cargo.toml", "rust-project.json"),
	settings = {
		["rust-analyzer"] = {
			completion = {
				addCallArgumentSnippets = true, -- add snippets for function call arguments
				enableSnippetCompletions = true, -- enable snippet completions
			},
			assist = {
				importGranularity = "Crate", -- suggest imports at the crate level
				importPrefix = "by_self", -- prefer "use self::" over "use ::"
			},
			cargo = {
				loadOutDirsFromCheck = true, -- improve performance by reusing build artifacts
			},
		},
	},
})

-- bash and shell script lsp
nvim_lsp.bashls.setup({
	cmd = { "bash-language-server", "start" },
	cmd_env = { GLOB_PATTERN = "*@(.sh|.inc|.bash|.command)" },
	filetypes = { "sh", "bash", "dash" },
	root_dir = nvim_lsp.util.find_git_ancestor,
	settings = {
		bashls = {
			filetypes = { "sh", "bash", "dash" },
			lint = {
				severity = "error", -- treat all lint warnings as errors
				enable = true,
				ignorePatterns = {}, -- ignore specific issues if desired
			},
			debug = {
				enableStdin = true, -- improve debugging with better stdin support
			},
		},
	},
})

-- Set logging level for LSP messages
vim.lsp.set_log_level("debug")
