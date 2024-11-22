require "staline".setup {
	sections = {
		left = { '  ', 'mode', ' ', 'branch', ' ', 'lsp' },
    mid = { 'file_type' },  -- Add file type in the middle section
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
  stab_right  = "⎯",  -- More distinct separator for inactive buffers

    -- fg       = Default is fg of "Normal".
    -- bg       = Default is bg of "Normal".
  inactive_bg = "#2e3338", -- Darker background for inactive tabs
  inactive_fg = "#a0a0a0", -- Lighter gray for inactive text
    font_active = "bold",
    exclude_fts = { 'NvimTree', 'dashboard', 'lir' },
    stab_start  = "",   -- The starting of stabline
    stab_end    = "",
    numbers = function(bufn, n)
    return '  ['..n..']'  -- Enclose buffer numbers in square brackets
    end
}
