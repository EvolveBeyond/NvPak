require("lsp_lines").setup()

-- error and warning management
vim.diagnostic.config({
    virtual_text = false,
	virtual_lines = {
		only_current_line = true,
		spacing = 5,
		severity_limit = "Warning",
	},
})

require("packages.bindings.lsp_lines") -- bindings
