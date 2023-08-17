local lualine = require("lualine")
local lsp_status = require("packages.ui.lualine.lsp_status")
local lsp_progress = require("packages.ui.lualine.lsp_progress")
local file_status = require("packages.ui.lualine.file_status")

local colors = {
	-- Use vim.fn.synIDattr to get colors from the current Neovim color scheme
	yellow = vim.fn.synIDattr(vim.fn.hlID("WarningMsg"), "fg"),
	cyan = vim.fn.synIDattr(vim.fn.hlID("Function"), "fg"),
	darkblue = vim.fn.synIDattr(vim.fn.hlID("StatusLineNC"), "fg"),
	green = vim.fn.synIDattr(vim.fn.hlID("Keyword"), "fg"),
	orange = vim.fn.synIDattr(vim.fn.hlID("Conditional"), "fg"),
	violet = vim.fn.synIDattr(vim.fn.hlID("Statement"), "fg"),
	magenta = vim.fn.synIDattr(vim.fn.hlID("String"), "fg"),
	blue = vim.fn.synIDattr(vim.fn.hlID("Type"), "fg"),
	red = vim.fn.synIDattr(vim.fn.hlID("Error"), "fg"),
}

local mode_color = {
	n = colors.red,
	i = colors.green,
	v = colors.blue,
	[""] = colors.blue,
	V = colors.blue,
	c = colors.magenta,
	no = colors.red,
	s = colors.orange,
	S = colors.orange,
	[""] = colors.orange,
	ic = colors.yellow,
	R = colors.violet,
	Rv = colors.violet,
	cv = colors.red,
	ce = colors.red,
	r = colors.cyan,
	rm = colors.cyan,
	["r?"] = colors.cyan,
	["!"] = colors.red,
	t = colors.red,
}

local mode_icons = {
	["n"] = "  ",
	["no"] = "  ",
	["niI"] = "  ",
	["niR"] = "  ",
	["no"] = "  ",
	["niV"] = "  ",
	["nov"] = "  ",
	["noV"] = "  ",
	["i"] = "  ",
	["ic"] = "  ",
	["ix"] = "  ",
	["s"] = "  ",
	["S"] = "  ",
	["v"] = "  ",
	["V"] = "  ",
	[""] = "  ",
	["r"] = " ﯒ ",
	["r?"] = "  ",
	["c"] = "  ",
	["t"] = "  ",
	["!"] = "  ",
	["R"] = "  ",
}

-- Config
local config = {
	options = {
		-- Disable sections and component separators
		component_separators = "",
		section_separators = "",
		theme = "auto",
	},
	sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		-- These will be filled later
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

ins_left({
	-- mode component
	function()
		return mode_icons[vim.fn.mode()]
	end,
	color = function()
		-- auto change color according to neovims mode
		return {
			fg = mode_color[vim.fn.mode()],
		}
	end,
	padding = { right = 1 },
})

-- Insert the filename component into the left section
ins_left({ "filename", file_status.buffer_not_empty })

-- Place the distance generation component in the left part.
ins_left({ "%=" })

-- Insert the LSP status component into the left section
ins_left({
	lsp_status.get,
	color = function()
		return { fg = colors.blue }
	end,
})
ins_left({
	lsp_progress,
	color = function()
		return { fg = colors.yellow }
	end,
})

-- Insert the encoding, file format, and file type components into the right section
ins_right("encoding")
ins_right("fileformat")
ins_right("filetype")

-- Define the lualine configuration
lualine.setup(config)
