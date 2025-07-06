-- Core module for interacting with rocks.nvim
local M = {}

local rocks_api = nil
local rocks_available = false

-- Attempt to load rocks.nvim API
local status_ok, rocks = pcall(require, "rocks")
if status_ok then
    rocks_api = rocks
    rocks_available = true
    vim.notify("Successfully loaded rocks.nvim API", vim.log.levels.INFO)
else
    vim.notify("Failed to load rocks.nvim API. rocks-tui may not function correctly.", vim.log.levels.ERROR)
end

--- Checks if rocks.nvim is available
--- @return boolean
function M.is_rocks_available()
    return rocks_available
end

--- Gets the loaded rocks.nvim API
--- @return table|nil
function M.get_rocks_api()
    return rocks_api
end

--- Get installed plugins
-- This is a placeholder. We need to figure out how rocks.nvim stores this.
-- It might be by reading rocks.toml or using an API function.
--- @return table List of installed plugins (e.g., { {name="plugin1", version="1.0.0"}, ...})
function M.get_installed_plugins()
    if not rocks_available then
        vim.notify("rocks.nvim not available", vim.log.levels.ERROR)
        return {}
    end

    -- Placeholder implementation
    -- Try to find a function in rocks_api or parse rocks.toml
    -- For now, return dummy data
    vim.notify("M.get_installed_plugins() called - Placeholder implementation", vim.log.levels.WARN)

    -- Example of how one might try to use the API if it exists
    -- if rocks_api and rocks_api.list_installed then
    --   return rocks_api.list_installed()
    -- end

    -- Fallback: try to read rocks.toml
    -- local toml_path = vim.fn.stdpath("config") .. "/rocks.toml" -- This path might be wrong
    -- local toml_content = read_file(toml_path) -- This would need a helper
    -- if toml_content then
    --   -- parse toml_content
    -- end

    return {
        { name = "plenary.nvim", version = "scm", status = "pinned" },
        { name = "telescope.nvim", version = "0.1.5", status = "ok" },
    }
end

--- Search for plugins
-- Placeholder: rocks.nvim might have a search API, or we might need to parse command output
--- @param query string Search query
--- @return table List of search results
function M.search_plugins(query)
    if not rocks_available then
        vim.notify("rocks.nvim not available", vim.log.levels.ERROR)
        return {}
    end
    vim.notify("M.search_plugins() called with query: " .. query .. " - Placeholder implementation", vim.log.levels.WARN)

    -- Example: if rocks_api and rocks_api.search then
    --   return rocks_api.search(query)
    -- end

    -- Fallback: use :Rocks search and parse output (complex)
    -- vim.cmd("Rocks search " .. query)
    -- Need a way to capture and parse this output.

    return {
        { name = "nvim-cmp", description = "A completion plugin for neovim" },
        { name = "lualine.nvim", description = "A blazing fast and easy to configure neovim statusline" },
    }
end

--- Install a plugin
--- @param plugin_name_or_url string Name or URL of the plugin
--- @param version string|nil Optional version
--- @return boolean Success status
function M.install_plugin(plugin_name_or_url, version)
    if not rocks_available then
        vim.notify("rocks.nvim not available", vim.log.levels.ERROR)
        return false
    end
    vim.notify("M.install_plugin() called for: " .. plugin_name_or_url .. (version and ("@"..version) or ""), vim.log.levels.INFO)

    local cmd = "Rocks install " .. plugin_name_or_url
    if version then
        cmd = cmd .. " " .. version
    end

    -- This is a simplified call. Real implementation needs to handle async nature,
    -- progress, and errors from rocks.nvim.
    local status, err = pcall(vim.cmd, cmd)
    if not status then
        vim.notify("Error installing plugin: " .. err, vim.log.levels.ERROR)
        return false
    else
        vim.notify("Plugin installation initiated for: " .. plugin_name_or_url, vim.log.levels.INFO)
        -- Ideally, we'd get more detailed feedback from rocks.nvim
        return true
    end
end

--- Update a specific plugin
--- @param plugin_name string Name of the plugin to update
--- @return boolean Success status
function M.update_plugin(plugin_name)
    if not rocks_available then
        vim.notify("rocks.nvim not available", vim.log.levels.ERROR)
        return false
    end
    vim.notify("M.update_plugin() called for: " .. plugin_name, vim.log.levels.INFO)

    local cmd = "Rocks update " .. plugin_name
    local status, err = pcall(vim.cmd, cmd)
    if not status then
        vim.notify("Error updating plugin: " .. err, vim.log.levels.ERROR)
        return false
    else
        vim.notify("Plugin update initiated for: " .. plugin_name, vim.log.levels.INFO)
        return true
    end
end

--- Update all plugins
--- @return boolean Success status
function M.update_all_plugins()
    if not rocks_available then
        vim.notify("rocks.nvim not available", vim.log.levels.ERROR)
        return false
    end
    vim.notify("M.update_all_plugins() called", vim.log.levels.INFO)

    local cmd = "Rocks update"
    local status, err = pcall(vim.cmd, cmd)
    if not status then
        vim.notify("Error updating all plugins: " .. err, vim.log.levels.ERROR)
        return false
    else
        vim.notify("Updating all plugins initiated.", vim.log.levels.INFO)
        return true
    end
end

--- Remove (prune) a plugin
--- @param plugin_name string Name of the plugin to remove
--- @return boolean Success status
function M.remove_plugin(plugin_name)
    if not rocks_available then
        vim.notify("rocks.nvim not available", vim.log.levels.ERROR)
        return false
    end
    vim.notify("M.remove_plugin() called for: " .. plugin_name, vim.log.levels.INFO)

    local cmd = "Rocks prune " .. plugin_name
    local status, err = pcall(vim.cmd, cmd)
    if not status then
        vim.notify("Error removing plugin: " .. err, vim.log.levels.ERROR)
        return false
    else
        vim.notify("Plugin removal initiated for: " .. plugin_name, vim.log.levels.INFO)
        return true
    end
end

--- Get logs from rocks.nvim
-- This function will attempt to open the logs using the :Rocks log command.
function M.view_log()
    if not rocks_available then
        vim.notify("rocks.nvim not available. Cannot show logs.", vim.log.levels.ERROR)
        return
    end

    vim.notify("Attempting to open rocks.nvim log...", vim.log.levels.INFO)
    local status_ok, err = pcall(vim.cmd, "Rocks log")
    if not status_ok then
        vim.notify("Failed to open rocks.nvim log: " .. (err or "Unknown error"), vim.log.levels.ERROR)
    else
        vim.notify("rocks.nvim log command executed. It should open in a new buffer/split.", vim.log.levels.INFO)
    end
end

-- TODO:
-- - Explore the actual `rocks_api` table to find available functions.
--   This might involve printing its contents or using `vim.inspect`.
-- - Implement robust parsing for `rocks.toml` if direct API calls for listing plugins are not available.
-- - Develop strategies for handling asynchronous operations from `rocks.nvim`.
--   This will be crucial for progress updates. `vim.loop.spawn` or `vim.fn.jobstart`
--   might be needed if we are calling `rocks.nvim` CLI commands directly for some operations.
-- - Add functions for `sync`, `pin`, `unpin`.

-- #############################################################################
-- Progress Reporting (Conceptual)
-- #############################################################################

-- This function would be called by rocks.nvim hooks or by wrappers around
-- rocks.nvim commands if we were parsing output.
local function report_progress_to_ui(data)
    -- Ensure ui module is loaded to avoid errors if it's not yet used
    local ui_status_ok, ui = pcall(require, "rocks-tui.ui")
    if ui_status_ok then
        -- Schedule the UI update to run in the main Neovim loop
        -- This is important if the progress reporting comes from an async callback
        vim.schedule(function()
            ui.update_installation_progress(data)
        end)
    else
        vim.notify("rocks-tui.ui module not found for progress update.", vim.log.levels.ERROR)
    end
end

-- Example of how a wrapped command might work (very simplified):
local function example_install_with_progress(plugin_name)
    report_progress_to_ui({
        overall_progress = 0.1,
        current_operation = "Starting install for " .. plugin_name,
        plugins_processed = 0, -- Assuming this is part of a batch
        total_plugins = 1,     -- Assuming this is part of a batch
        detailed_statuses = {{ name = plugin_name, status = "pending" }}
    })

    -- Simulate some work
    -- In reality, this would be vim.fn.jobstart() or similar, with event handlers
    -- that call report_progress_to_ui on stdout/stderr or on exit.
    vim.defer_fn(function()
        report_progress_to_ui({
            overall_progress = 0.5,
            current_operation = "Downloading " .. plugin_name .. "...",
            plugins_processed = 0,
            total_plugins = 1,
            detailed_statuses = {{ name = plugin_name, status = "downloading" }}
        })
    end, 500)

    vim.defer_fn(function()
        report_progress_to_ui({
            overall_progress = 1.0,
            current_operation = "Finished installing " .. plugin_name,
            plugins_processed = 1,
            total_plugins = 1,
            detailed_statuses = {{ name = plugin_name, status = "installed" }}
        })
        -- Maybe close progress window automatically after a short delay if it's the last one
        -- vim.defer_fn(function()
        --     local ui = require('rocks-tui.ui')
        --     if ui then ui.close_installation_progress_window() end
        -- end, 2000)
    end, 1500)

    -- The actual vim.cmd or API call would go here.
    -- For now, this is just a placeholder for the concept.
    vim.notify("Conceptual install for " .. plugin_name .. " (with progress) finished.", vim.log.levels.INFO)
end

-- Replace M.install_plugin with a version that could conceptually report progress
-- This is a simplified example. A real implementation would need to properly manage
-- async jobs and parse their output or use rocks.nvim's Lua API events if available.
function M.install_plugin(plugin_name_or_url, version)
    if not rocks_available then
        vim.notify("rocks.nvim not available", vim.log.levels.ERROR)
        return false
    end
    vim.notify("M.install_plugin() called for: " .. plugin_name_or_url .. (version and ("@"..version) or ""), vim.log.levels.INFO)

    -- Open the progress window when an install starts
    local ui_status_ok, ui = pcall(require, "rocks-tui.ui")
    if ui_status_ok then
        vim.schedule(function() ui.open_installation_progress_window() end)
    end

    -- Call the example conceptual function (or a real one later)
    example_install_with_progress(plugin_name_or_url)
    -- The actual command would be here, and its output/events would drive report_progress_to_ui
    -- For example:
    -- local cmd = "Rocks install " .. plugin_name_or_url
    -- if version then
    --     cmd = cmd .. " " .. version
    -- end
    -- vim.fn.jobstart(cmd, { on_stdout = ..., on_stderr = ..., on_exit = ...})

    return true -- Assuming initiation is success for now
end


-- Similar wrappers would be needed for update_plugin, update_all_plugins, remove_plugin,
-- and a new function for :Rocks sync.


return M
