-- Configuration module for rocks-tui
local M = {}

local default_config = {
    keymaps = {
        -- Plugin Manager Window
        manager_close = "q",
        manager_refresh = "r",
        manager_update_selected = "u",
        manager_remove_selected = "R",
        manager_update_all = "U",
        manager_sync = "s",
        manager_view_log = "l",
        -- Search Results Window
        search_close = "q",
        search_install_selected = "i",
        -- Progress Window
        progress_close = "q",
    },
    ui = {
        manager_window = {
            border = "rounded", -- "none", "single", "double", "rounded", "solid", "shadow"
            width_ratio = 0.8,  -- Ratio of editor width
            height_ratio = 0.7, -- Ratio of editor height
            title = "rocks.nvim TUI - Manager",
        },
        search_window = {
            border = "rounded",
            width_ratio = 0.8,
            height_ratio = 0.7,
            title = "Plugin Search Results",
        },
        progress_window = {
            border = "double",
            width_ratio = 0.7,
            height_ratio = 0.5,
            title = "Installation Progress",
            zindex = 100,
        },
        -- Common highlight groups (can be overridden by user's theme if not set)
        -- Normal = "NormalFloat",
        -- FloatBorder = "FloatBorder",
    }
}

local current_config = vim.deepcopy(default_config)

--- Merges user configuration with defaults.
--- @param user_config table User-provided configuration table.
function M.setup(user_config)
    if user_config and type(user_config) == "table" then
        current_config = vim.tbl_deep_extend("force", vim.deepcopy(default_config), user_config)
    else
        current_config = vim.deepcopy(default_config) -- Reset if invalid config
    end
    -- Basic validation could be added here if needed
end

--- Returns the current configuration table.
--- @return table
function M.get_config()
    return current_config
end

return M
