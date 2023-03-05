-- requirements
local heirline = require("heirline")
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local web_icons = require("nvim-web-devicons")

-- StatusLine widgets



local function setup_colors()
	return {
		bright_bg = utils.get_highlight("Folded").bg,
		bright_fg = utils.get_highlight("Folded").fg,
		red = utils.get_highlight("DiagnosticError").fg,
		dark_red = utils.get_highlight("DiffDelete").bg,
		green = utils.get_highlight("String").fg,
		blue = utils.get_highlight("Function").fg,
		gray = utils.get_highlight("NonText").fg,
		orange = utils.get_highlight("Constant").fg,
		purple = utils.get_highlight("Statement").fg,
		cyan = utils.get_highlight("Special").fg,
		diag_warn = utils.get_highlight("DiagnosticWarn").fg,
		diag_error = utils.get_highlight("DiagnosticError").fg,
		diag_hint = utils.get_highlight("DiagnosticHint").fg,
		diag_info = utils.get_highlight("DiagnosticInfo").fg,
		git_add = utils.get_highlight("diffAdded").fg,
	}
end

heirline.setup({
	statusline = {},
	tabline = {},
})

-- other bar config
vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])

-- color theme auto set
heirline.load_colors(setup_colors())
vim.api.nvim_create_augroup("Heirline", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		local colors = setup_colors()
		utils.on_colorscheme(colors)
	end,
	group = "Heirline",
})
