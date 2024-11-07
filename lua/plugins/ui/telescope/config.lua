-- import telescope plugin safely
local telescope = require("telescope")
local theme = require("telescope.themes")
-- Bindings
local hotkeys = require("plugins.ui.telescope.bind")

-- configure telescope
local mappings = hotkeys.mappings
telescope.setup({
    -- configure custom mappings
    defaults = {
        mappings,
    },
    extensions = {
        ["ui-select"] = theme.get_dropdown({
            -- even more opts
        }),
        -- fzf = {
        --     fuzzy = true,                   -- false will only do exact matching
        --     override_generic_sorter = true, -- override the generic sorter
        --     override_file_sorter = true,    -- override the file sorter
        --     case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        --     -- the default case_mode is "smart_case"
        -- },
    },
})

-- telescope.load_extension('fzf')
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension("ui-select")
-- telescope notify plugin
telescope.load_extension("notify")
