local found_mason, mason = pcall(require, "mason")
local found_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
local found_nvim_lsp, nvim_lsp = pcall(require, "lspconfig")
local found_mason_dap, mason_dap = pcall(require, "mason-nvim-dap")
local found_lsp_file, lsp_file = pcall(require, "lsp-file-operations")

if found_mason and found_mason_lspconfig and found_nvim_lsp then
	-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

	-- The following example advertise capabilities to `clangd`.
	nvim_lsp.clangd.setup({
		capabilities = capabilities,
	})

	-- Lsp File Operations
	if found_lsp_file then
		lsp_file.setup({})
	end

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
		ensure_installed = {
			"lua_ls", -- lua language server
			"rust_analyzer", -- rust language server
			"pylsp", -- python language server
			"pyre", -- python language server
		},
	})

	-- auto install debugers
	if found_mason_dap then
		mason_dap.setup({
			ensure_installed = { "lua", "rust", "python" },
		})
	end

	-- Lua long Lsp Config
	nvim_lsp.sumneko_lua.setup({
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
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
		settings = {
			pylsp = {
				plugins = {
					pycodestyle = {
						ignore = { "W391" },
						maxLineLength = 100,
					},
				},
			},
		},
	})

	-- python static lsp
	nvim_lsp.pyre.setup({
		cmd = { "pyre", "persistent" },
		filetypes = { "python" },
	})

	-- rust_analyzer Config
	nvim_lsp.rust_analyzer.setup({
		cmd = { "rust_analyzer" },
		filetypes = { "rust" },
		root_dir = nvim_lsp.util.root_pattern("Cargo.toml", "rust-project.json"),
	})

	nvim_lsp.bashls.setup({
		cmd = { "bash-language-server", "start" },
		cmd_env = {
			GLOB_PATTERN = "*@(.sh|.inc|.bash|.command)",
		},
		filetypes = { "sh" },
		root_dir = nvim_lsp.util.find_git_ancestor,
		single_file_support = true,
	})

	-- dart lsp config
	-- nvim_lsp.dart.setup {}
	-- Or if you have Dartls installed
	-- nvim_lsp.dartls.setup{
	--       cmd = {"dart", "language-server", "--protocol=lsp"},
	--       filetypes = {"dart"},
	--       init_options = {
	--                       closingLabels = true,
	--                       flutterOutline = true,
	--                       onlyAnalyzeProjectsWithOpenFiles = true,
	--                       outline = true,
	--                       suggestFromUnimportedLibraries = true
	--                     },
	--       root_dir = nvim_lsp.util.root_pattern("pubspec.yaml"),
	--       settings = {
	--               dart = {
	--                       completeFunctionCalls = true,
	--                       showTodos = true
	--                      }
	--                  }
	--               }
	--
end

-- vim.lsp.set_log_level("debug")
