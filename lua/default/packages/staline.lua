require "staline".setup {
	sections = {
		left = { '  ', 'mode', '  ', 'lsp_name', '  ', 'branch' },
		mid = {'lsp'},
		right = {'file_name', 'line_column' }
	},
	mode_colors = {
		i = "#ff0040",
		n = "#ADFBFF",
		c = "#00ff94",
		v = "#FFA200",
	},
	defaults = {
		true_colors = true,
		line_column = " [%l/%L] :%c  ",
		branch_symbol = " "
	}
}

