local lualine = require("lualine")
local lsp_status = require("packages.ui.lualine.lsp_status")
local file_status = require("packages.ui.lualine.file_status")

-- Config
local config = {
	options = {
		-- Disable sections and component separators
		component_separators = "",
		section_separators = "",
		theme = {
			-- We are going to use lualine_c an lualine_x as left and
			-- right section. Both are highlighted by c theme .  So we
			-- are just setting default looks o statusline
			normal = { c = {} },
			inactive = { c = {} },
		},
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

-- Insert the filename component into the left section
ins_left({ "filename", cond = file_status.buffer_not_empty })

-- Place the distance generation component in the left part.
ins_left({ "%=" })

-- Insert the LSP status component into the left section
ins_left({ lsp_status.get })

-- Insert the encoding, file format, and file type components into the right section
ins_right("encoding")
ins_right("fileformat")
ins_right("filetype")

-- Define the lualine configuration
lualine.setup(config)
