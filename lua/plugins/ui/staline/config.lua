
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
	}
}

require('stabline').setup {
    style       = "bar", -- others: arrow, slant, bubble
    stab_left   = "┃",
    stab_right  = " ",

    -- fg       = Default is fg of "Normal".
    -- bg       = Default is bg of "Normal".
    inactive_bg = "#1e2127",
    inactive_fg = "#aaaaaa",
    -- stab_bg  = Default is darker version of bg.,

    font_active = "bold",
    exclude_fts = { 'NvimTree', 'dashboard', 'lir' },
    stab_start  = "",   -- The starting of stabline
    stab_end    = "",
    numbers = function(bufn, n)
        return '*'..n..' '
    end
}
