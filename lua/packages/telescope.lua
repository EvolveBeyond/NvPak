-- import telescope plugin safely
local telescope = require("telescope")
-- Bindings
local hotkeys = require("packages.bindings.telescope")

-- configure telescope
telescope.setup({
	-- configure custom mappings
	defaults = {
		hotkeys.mappings,
	},
})

telescope.load_extension("fzf")
telescope.load_extension("flutter")
telescope.load_extension("ui-select")
