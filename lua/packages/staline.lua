require("staline").setup({
	sections = {
		left = { "  ", "mode", "  ", "lsp_name", "  ", "branch" },
		mid = { "lsp" },
		right = { "file_name", "line_column" },
	},
	mode_colors = {
		i = "#ff0040",
		n = "#ADFBFF",
		c = "#00ff94",
		v = "#FFA200",
	},
	defaults = {
		null_ls_symbol = "[Null-ls]",
		expand_null_ls = true,
		true_colors = true,
		line_column = " [%l/%L] :%c  ",
		branch_symbol = " ",
	},
})

require("stabline").setup({
	style = "bar",
	stab_left = "|",
	bg = "#242b38",
	fg = "#ffffff",
	inactive_bg = "#1e2127",
	inactive_fg = "#ffffff",
	font_active = "bold",
	exclude_fts = { "NvimTree", "dashboard", "lir" },
	stab_start = "",
	stab_end = "",
})
