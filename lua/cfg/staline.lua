require "staline".setup {
	sections = {
		left = { '  ', 'mode', ' ', 'branch', ' ', 'lsp' },
		mid = {},
		right = {'file_name', 'line_column' }
	},
	mode_colors = {
		i = "#d4be98",
		n = "#84a598",
		c = "#8fbf7f",
		v = "#fc802d",
	},
	defaults = {
		true_colors = true,
		line_column = " [%l/%L] :%c  ",
		branch_symbol = " "
	},
}

require('stabline').setup {
	style = "slant",
	-- bg = "", 	      -- bg       = Default is bg of "Normal".
	fg = "#84a598",   	-- fg       = Default is fg of "Normal".
	stab_right = "",

	inactive_bg = "#1e2127",
	inactive_fg = "#aaaaaa",
	-- stab_bg     = Default is darker version of bg.,

	font_active = "bold",
	exclude_fts = { 'NvimTree', 'dashboard', 'lir' },
	stab_start  = "",   -- The starting of stabline
	stab_end    = "",
}
