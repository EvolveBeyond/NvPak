local set = vim.opt
local blackline = require("indent_blankline")

set.list = true

blackline.setup({
	show_end_of_line = true,
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
})
