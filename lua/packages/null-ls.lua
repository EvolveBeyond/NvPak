local found_null_ls, null_ls = pcall(require, "null-ls")
local found_lsp, nvim_lsp = pcall(require, "lspconfig")
local found_mason_null_ls, mason_null_ls = pcall(require, "mason-null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end,
		})
	end
end

-- null ls config
if found_null_ls and found_mason_null_ls and found_lsp then
	-- null-ls server Configure
	local b = null_ls.builtins
	local packages = {
		b.diagnostics.mypy,
		b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),
		b.formatting.black,
		b.formatting.dart_format,
		b.formatting.isort,
		b.formatting.prettier,
		b.formatting.shfmt,
		b.formatting.sql_formatter,
		b.formatting.stylua,
		b.completion.spell,
	}

	-- Null-ls Config
	null_ls.setup({
		on_attach = on_attach,
		debug = true,
		sources = packages,
	})

	-- Mason Package Manager config for null-ls
	mason_null_ls.setup({
		ensure_installed = {
			-- Write your desired package here instead of above (for people who don't like the automatic system and use space + f)
			-- for example "black"
		},
		automatic_installation = true,
		automatic_setup = false,
	})

	nvim_lsp.format_on_save = {
		pattern = { "*.lua", "*.py", "*.go" },
	}
else
	return
end
