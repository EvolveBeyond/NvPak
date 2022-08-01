require "staline".setup {
	sections = {
		left = { '  ', 'mode', '  ', 'lsp_name', '  ', 'branch' },
		mid = {'lsp'},
		right = {'file_name', 'line_column' }
	},
	mode_colors = {
		i = "#FFBF00",
		n = "#50C878",
		c = "#FFD700",
		v = "#7F00FF",
	},
	defaults = {
		true_colors = true,
		line_column = " [%l/%L] :%c  ",
		branch_symbol = " "
	}
}
