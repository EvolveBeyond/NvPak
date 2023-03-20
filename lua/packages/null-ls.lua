local null_ls = require("null-ls")
local nvim_lsp = require("lspconfig")
local mason_null_ls = require("mason-null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		--[[
                 If you remove this section from the comment, every time you save your file, it will be automatically formatted as text.
                Otherwise, just use the Ctrl + f keys.
        --]]
		-- vim.api.nvim_create_autocmd("BufWritePre", {
		-- 	group = augroup,
		-- 	buffer = bufnr,
		-- 	callback = function()
		-- 		vim.lsp.buf.format({ bufnr = bufnr })
		-- 	end,
		-- })
	end
end
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
		-- Write your desired package here instead of above (for people who don't like the automatic system and use Ctrl + f)
		-- for example "black"
	},
	automatic_installation = true,
	automatic_setup = false,
})

nvim_lsp.format_on_save = {
	pattern = { "*.lua", "*.py", "*.rs" },
}
