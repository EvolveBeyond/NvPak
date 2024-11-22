-- Helper for safely requiring modules
local function safe_require(module)
  local ok, result = pcall(require, module)
  return ok and result or nil
end

-- Import plugins safely
local telescope = safe_require("telescope")
if not telescope then
  vim.notify("Telescope not found", vim.log.levels.ERROR)
  return
end

local theme = safe_require("telescope.themes")
local hotkeys = safe_require("plugins.ui.telescope.bind")

-- Configure Telescope
local mappings = hotkeys and hotkeys.mappings or {}

telescope.setup({
    defaults = {
    mappings = mappings,
    -- Add more default options here if needed
    },
    extensions = {
    ["ui-select"] = theme and theme.get_dropdown({
      previewer = false, -- Disable preview window
      layout_config = {
        width = 0.5, -- 50% width
        height = 0.4, -- 40% height
      },
      prompt_title = "Select Option",
    }),
    -- Uncomment for FZF integration
        -- fzf = {
    --     fuzzy = true,                   -- Enable fuzzy matching
    --     override_generic_sorter = true, -- Override generic sorter
    --     override_file_sorter = true,    -- Override file sorter
    --     case_mode = "smart_case",       -- Smart case matching
        -- },
    },
})

-- Load extensions
telescope.load_extension("ui-select")
telescope.load_extension("notify")
-- telescope.load_extension("fzf") -- Uncomment if FZF is enabled
