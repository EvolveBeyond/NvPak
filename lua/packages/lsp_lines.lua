local lsp_lines = require("lsp_lines")

-- erorr and Warning managment
vim.diagnostic.config({
	virtual_text = false, -- Disable virtual_text since it's redundant due to lsp_lines.
	virtual_lines = {
		only_current_line = true,
		spacing = 5,
		severity_limit = "Warning",
	},
})

lsp_lines.setup()

require("packages.bindings.lsp_lines") -- bindings
