-- UI Module for rocks-tui
local M = {}

local core = require('rocks-tui.core')
local config_module = require('rocks-tui.config')

local api = vim.api
local fn = vim.fn

local current_bufnr = nil
local current_winid = nil

local installed_plugins_cache = {}

--- Close the current TUI window
local function close_window()
    if current_winid and api.nvim_win_is_valid(current_winid) then
        api.nvim_win_close(current_winid, true)
    end
    if current_bufnr and api.nvim_buf_is_valid(current_bufnr) then
        -- Can't delete if it's the current buffer, ensure it's not
        -- api.nvim_buf_delete(current_bufnr, { force = true })
    end
    current_bufnr = nil
    current_winid = nil
end

--- Refresh the content of the plugin list window
local function refresh_plugin_list()
    if not (current_bufnr and api.nvim_buf_is_valid(current_bufnr)) then
        return
    end

    installed_plugins_cache = core.get_installed_plugins() -- Fetch fresh data

    local lines = { "Installed Plugins (rocks-tui)", "---------------------------------" }
    if #installed_plugins_cache == 0 then
        table.insert(lines, "No plugins found or rocks.nvim not fully initialized.")
        table.insert(lines, "Try running :Rocks sync")
    else
        for i, plugin in ipairs(installed_plugins_cache) do
            local status = plugin.status or "N/A"
            local version = plugin.version or "N/A"
            table.insert(lines, string.format("%d. %-30s [%-10s] (%s)", i, plugin.name, version, status))
        end
    end
    table.insert(lines, "---------------------------------")
    table.insert(lines, "Mappings: (q)uit, (r)efresh, (l)ogs")
    table.insert(lines, "          (u)pdate sel, (R)emove sel, (U)pdate All, (s)ync")


    api.nvim_buf_set_option(current_bufnr, "modifiable", true)
    api.nvim_buf_set_lines(current_bufnr, 0, -1, false, lines)
    api.nvim_buf_set_option(current_bufnr, "modifiable", false)
end

--- Handle actions on a selected plugin
local function handle_plugin_action(action)
    local line_nr = api.nvim_win_get_cursor(0)[1]
    -- Assuming header lines, adjust index accordingly
    -- Header: 2 lines, content starts at line 3. So index is line_nr - 2.
    local plugin_index = line_nr - 2

    if plugin_index > 0 and plugin_index <= #installed_plugins_cache then
        local plugin = installed_plugins_cache[plugin_index]
        if not plugin then
            vim.notify("Could not get plugin at line " .. line_nr, vim.log.levels.ERROR)
            return
        end

        if action == "update" then
            vim.notify(string.format("Updating %s...", plugin.name))
            core.update_plugin(plugin.name)
            -- Ideally, rocks.nvim would trigger an event or we'd have a callback
            -- For now, manual refresh or timed refresh might be needed.
            vim.defer_fn(refresh_plugin_list, 1000) -- Refresh after a delay
        elseif action == "remove" then
            fn.input(string.format("Really remove %s? [y/N]: ", plugin.name)):request(function(input)
                if input and string.lower(input) == "y" then
                    vim.notify(string.format("Removing %s...", plugin.name))
                    core.remove_plugin(plugin.name)
                    vim.defer_fn(refresh_plugin_list, 1000)
                else
                    vim.notify("Removal cancelled.", vim.log.levels.INFO)
                end
            end)
        else
            vim.notify("Unknown action: " .. action, vim.log.levels.WARN)
        end
    else
        vim.notify("No plugin selected or invalid line.", vim.log.levels.WARN)
    end
end

--- Setup key mappings for the TUI window
local function setup_tui_mappings(bufnr)
    local cfg = config_module.get_config()
    local keymaps = cfg.keymaps

    local map_opts = { noremap = true, silent = true, nowait = true }

    api.nvim_buf_set_keymap(bufnr, "n", keymaps.manager_close, "<Cmd>lua require('rocks-tui.ui').close_managed_window()<CR>", map_opts)
    api.nvim_buf_set_keymap(bufnr, "n", keymaps.manager_refresh, "<Cmd>lua require('rocks-tui.ui').refresh_ui()<CR>", map_opts)

    -- Actions on selected plugin
    api.nvim_buf_set_keymap(bufnr, "n", keymaps.manager_update_selected, "<Cmd>lua require('rocks-tui.ui').trigger_plugin_action('update')<CR>", map_opts)
    api.nvim_buf_set_keymap(bufnr, "n", keymaps.manager_remove_selected, "<Cmd>lua require('rocks-tui.ui').trigger_plugin_action('remove')<CR>", map_opts)

    -- Global actions
    local update_all_cmd = string.format("<Cmd>lua require('rocks-tui.core').update_all_plugins()<CR><Cmd>lua vim.defer_fn(require('rocks-tui.ui').refresh_ui, 1000)<CR>")
    api.nvim_buf_set_keymap(bufnr, "n", keymaps.manager_update_all, update_all_cmd, vim.tbl_extend("force", map_opts, {desc = "Update All Plugins"}))

    local sync_cmd = string.format("<Cmd>Rocks sync<CR><Cmd>lua vim.defer_fn(require('rocks-tui.ui').refresh_ui, 1000)<CR>")
    api.nvim_buf_set_keymap(bufnr, "n", keymaps.manager_sync, sync_cmd, vim.tbl_extend("force", map_opts, {desc = "Sync with rocks.toml"}))

    api.nvim_buf_set_keymap(bufnr, "n", keymaps.manager_view_log, "<Cmd>lua require('rocks-tui.core').view_log()<CR>", vim.tbl_extend("force", map_opts, {desc = "View rocks.nvim Logs"}))
end

--- Public function to be called by keymaps for actions
function M.trigger_plugin_action(action_name)
    handle_plugin_action(action_name)
end

--- Public function to be called by keymap for closing
function M.close_managed_window()
    close_window()
end

--- Public function to be called by keymap for refreshing
function M.refresh_ui()
    refresh_plugin_list()
    vim.notify("Plugin list refreshed.", vim.log.levels.INFO)
end


--- Open the plugin management window
function M.open_plugin_manager()
    if current_winid and api.nvim_win_is_valid(current_winid) then
        api.nvim_set_current_win(current_winid)
        return
    end

    current_bufnr = api.nvim_create_buf(false, true) -- false: not listed, true: scratch
    api.nvim_buf_set_option(current_bufnr, "bufhidden", "wipe")
    api.nvim_buf_set_option(current_bufnr, "buftype", "nofile")
    api.nvim_buf_set_option(current_bufnr, "swapfile", false)
    api.nvim_buf_set_option(current_bufnr, "filetype", "RocksTUI") -- For potential syntax highlighting or ftplugins

    local cfg = config_module.get_config().ui.manager_window
    local editor_cols = api.nvim_get_option("columns")
    local editor_lines = api.nvim_get_option("lines")

    local width = math.floor(editor_cols * cfg.width_ratio)
    local height = math.floor(editor_lines * cfg.height_ratio)
    local row = math.floor((editor_lines - height) / 2)
    local col = math.floor((editor_cols - width) / 2)

    local win_opts = {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = cfg.border,
        title = cfg.title,
        title_pos = "center",
    }

    current_winid = api.nvim_open_win(current_bufnr, true, win_opts)
    -- local winhl = string.format("Normal:%s,FloatBorder:%s",
    --                           config_module.get_config().ui.Normal or "NormalFloat",
    --                           config_module.get_config().ui.FloatBorder or "FloatBorder")
    -- api.nvim_win_set_option(current_winid, "winhl", winhl)
    -- It's often better to let users theme these via global highlights like NormalFloat, FloatBorder

    refresh_plugin_list()
    setup_tui_mappings(current_bufnr)
end


-- Placeholder for other UI components (Search, Progress)
local search_winid = nil
local search_bufnr = nil
local search_results_cache = {}

--- Close the current search window
local function close_search_window()
    if search_winid and api.nvim_win_is_valid(search_winid) then
        api.nvim_win_close(search_winid, true)
    end
    search_winid = nil
    -- search_bufnr = nil -- Optional: clear buffer too
end

--- Refresh the content of the search results window
local function refresh_search_results_list(query)
    if not (search_bufnr and api.nvim_buf_is_valid(search_bufnr)) then
        return
    end

    search_results_cache = core.search_plugins(query or "") -- Fetch fresh data

    local lines = { string.format("Search Results for '%s' (rocks-tui)", query or ""), "---------------------------------" }
    if #search_results_cache == 0 then
        table.insert(lines, "No plugins found for your query.")
    else
        for i, plugin in ipairs(search_results_cache) do
            table.insert(lines, string.format("%d. %-30s", plugin.name))
            table.insert(lines, string.format("   %s", plugin.description or "No description."))
        end
    end
    table.insert(lines, "---------------------------------")
    table.insert(lines, "Mappings: (q)uit, (i)nstall selected") -- TODO: Add install mapping

    api.nvim_buf_set_option(search_bufnr, "modifiable", true)
    api.nvim_buf_set_lines(search_bufnr, 0, -1, false, lines)
    api.nvim_buf_set_option(search_bufnr, "modifiable", false)
end

--- Handle install action on a selected search result
local function handle_search_install_action()
    local line_nr = api.nvim_win_get_cursor(0)[1]
    -- Header: 2 lines. Each plugin takes 2 lines. Index is (line_nr - 3) / 2 + 1
    -- Or, more simply, if we just select based on the plugin name line:
    -- (line_nr - 2) should be odd. plugin_index = (line_nr - 2 + 1) / 2
    if line_nr <= 2 then return end -- Clicked on header

    local item_index_on_screen = line_nr - 2
    -- Each item (name + desc) takes 2 lines. So the actual plugin index is:
    local plugin_index = math.floor((item_index_on_screen -1) / 2) + 1

    if plugin_index > 0 and plugin_index <= #search_results_cache then
        local plugin = search_results_cache[plugin_index]
        if not plugin then
            vim.notify("Could not get plugin at line " .. line_nr, vim.log.levels.ERROR)
            return
        end

        fn.input(string.format("Install %s? [y/N] (version can be specified, e.g., 'y 1.2.0' or 'y dev'): ", plugin.name)):request(function(input)
            if input and string.lower(input:match("^%s*(%S+)")) == "y" then
                local _, _, version_str = input:find("^%s*y%s*(.*)$")
                version_str = version_str and vim.trim(version_str) or nil
                if version_str == "" then version_str = nil end

                vim.notify(string.format("Attempting to install %s%s...", plugin.name, version_str and "@"..version_str or ""))
                core.install_plugin(plugin.name, version_str) -- core.install_plugin handles opening progress UI
                -- No need to refresh search results, but user might want to see it in main manager later
                close_search_window() -- Close search window after attempting install
            else
                vim.notify("Installation cancelled.", vim.log.levels.INFO)
            end
        end)
    else
        vim.notify("No plugin selected or invalid line for installation.", vim.log.levels.WARN)
    end
end


--- Setup key mappings for the search TUI window
local function setup_search_tui_mappings(bufnr)
    local cfg = config_module.get_config()
    local keymaps = cfg.keymaps
    local map_opts = { noremap = true, silent = true, nowait = true }

    api.nvim_buf_set_keymap(bufnr, "n", keymaps.search_close, "<Cmd>lua require('rocks-tui.ui').close_search_results_window()<CR>", map_opts)
    api.nvim_buf_set_keymap(bufnr, "n", keymaps.search_install_selected, "<Cmd>lua require('rocks-tui.ui').trigger_search_install_action()<CR>", map_opts)
    -- Potentially add 'r' to re-search with a new query or refresh current
end

--- Public function for search install action keymap
function M.trigger_search_install_action()
    handle_search_install_action()
end

--- Public function for closing search window keymap
function M.close_search_results_window()
    close_search_window()
end

--- Open the plugin search window
function M.open_search_window()
    if search_winid and api.nvim_win_is_valid(search_winid) then
        api.nvim_set_current_win(search_winid)
        return
    end

    vim.ui.input({ prompt = "Search on LuaRocks (or enter git URL):" }, function(query)
        if query == nil or query == "" then
            vim.notify("Search cancelled.", vim.log.levels.INFO)
            return
        end

        search_bufnr = api.nvim_create_buf(false, true)
        api.nvim_buf_set_option(search_bufnr, "bufhidden", "wipe")
        api.nvim_buf_set_option(search_bufnr, "buftype", "nofile")
        api.nvim_buf_set_option(search_bufnr, "swapfile", false)
        api.nvim_buf_set_option(search_bufnr, "filetype", "RocksTUISearch")

        local cfg = config_module.get_config().ui.search_window
        local editor_cols = api.nvim_get_option("columns")
        local editor_lines = api.nvim_get_option("lines")

        local width = math.floor(editor_cols * cfg.width_ratio)
        local height = math.floor(editor_lines * cfg.height_ratio)
        local row = math.floor((editor_lines - height) / 2)
        local col = math.floor((editor_cols - width) / 2)

        local win_opts = {
            relative = "editor",
            width = width,
            height = height,
            row = row,
            col = col,
            style = "minimal",
            border = cfg.border,
            title = cfg.title,
            title_pos = "center",
        }

        search_winid = api.nvim_open_win(search_bufnr, true, win_opts)
        -- Using global highlights like NormalFloat, FloatBorder is generally preferred

        refresh_search_results_list(query)
        setup_search_tui_mappings(search_bufnr)
    end)
end

local progress_winid = nil
local progress_bufnr = nil
local progress_cache = {} -- Store the latest progress data

local function create_progress_bar(percentage, width)
    local filled_width = math.floor(percentage * width)
    local empty_width = width - filled_width
    return "Progress: [" .. string.rep("=", filled_width) .. string.rep("-", empty_width) .. string.format("] %.0f%%", percentage * 100)
end

--- Updates or creates the installation progress window
--- @param data table Expected fields:
--    data.overall_progress (float, 0.0 to 1.0)
--    data.current_operation (string, e.g., "Syncing", "Installing plugin_name")
--    data.plugins_processed (number)
--    data.total_plugins (number)
--    data.log_messages (table of strings, optional)
function M.update_installation_progress(data)
    progress_cache = data -- Cache the latest data

    if not (progress_winid and api.nvim_win_is_valid(progress_winid)) then
        -- Window is not open, so don't try to update.
        -- It can be opened manually or by an event.
        return
    end

    if not (progress_bufnr and api.nvim_buf_is_valid(progress_bufnr)) then
        vim.notify("Progress buffer is invalid.", vim.log.levels.ERROR)
        return
    end

    local lines = { "rocks.nvim - Installation Progress", "------------------------------------" }

    local overall_progress = data.overall_progress or 0
    local current_op = data.current_operation or "Waiting for operation to start..."
    local plugins_processed = data.plugins_processed or 0
    local total_plugins = data.total_plugins or 0

    table.insert(lines, current_op)
    if total_plugins > 0 then
        table.insert(lines, string.format("Plugins: %d / %d", plugins_processed, total_plugins))
    end
    table.insert(lines, create_progress_bar(overall_progress, 40)) -- 40 char wide bar
    table.insert(lines, "------------------------------------")

    if data.detailed_statuses then
        for _, p_status in ipairs(data.detailed_statuses) do
            table.insert(lines, string.format("- %s: %s", p_status.name, p_status.status))
        end
        table.insert(lines, "------------------------------------")
    end


    if data.log_messages and #data.log_messages > 0 then
        for _, msg in ipairs(data.log_messages) do
            table.insert(lines, msg)
        end
    end

    api.nvim_buf_set_option(progress_bufnr, "modifiable", true)
    api.nvim_buf_set_lines(progress_bufnr, 0, -1, false, lines)
    api.nvim_buf_set_option(progress_bufnr, "modifiable", false)
end


--- Opens the installation progress window
function M.open_installation_progress_window()
    if progress_winid and api.nvim_win_is_valid(progress_winid) then
        api.nvim_set_current_win(progress_winid)
        return
    end

    progress_bufnr = api.nvim_create_buf(false, true)
    api.nvim_buf_set_option(progress_bufnr, "bufhidden", "wipe")
    api.nvim_buf_set_option(progress_bufnr, "buftype", "nofile")
    api.nvim_buf_set_option(progress_bufnr, "swapfile", false)
    api.nvim_buf_set_option(progress_bufnr, "filetype", "RocksTUIProgress")

    local cfg = config_module.get_config().ui.progress_window
    local editor_cols = api.nvim_get_option("columns")
    local editor_lines = api.nvim_get_option("lines")

    local width = math.floor(editor_cols * cfg.width_ratio)
    local height = math.floor(editor_lines * cfg.height_ratio)
    -- Position towards bottom, but ensure it's on screen
    local row = math.max(0, math.min(editor_lines - height -1, math.floor((editor_lines - height) * 0.8)))
    local col = math.floor((editor_cols - width) / 2)


    local win_opts = {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = cfg.border,
        title = cfg.title,
        title_pos = "center",
        zindex = cfg.zindex,
    }

    progress_winid = api.nvim_open_win(progress_bufnr, true, win_opts)
    -- Using global highlights like NormalFloat, FloatBorder is generally preferred

    -- Initial update with cached or default data
    M.update_installation_progress(progress_cache or {
        overall_progress = 0,
        current_operation = "Initializing...",
        plugins_processed = 0,
        total_plugins = 0,
        log_messages = {"Waiting for rocks.nvim operations..."}
    })

    -- Basic mapping to close this window
    local keymaps = config_module.get_config().keymaps
    local map_opts = { noremap = true, silent = true, nowait = true }
    api.nvim_buf_set_keymap(progress_bufnr, "n", keymaps.progress_close, "<Cmd>lua require('rocks-tui.ui').close_installation_progress_window()<CR>", map_opts)
end

--- Closes the installation progress window
function M.close_installation_progress_window()
    if progress_winid and api.nvim_win_is_valid(progress_winid) then
        api.nvim_win_close(progress_winid, true)
    end
    -- Don't delete buffer if we want to reopen with same content, but for progress, fresh is usually better.
    -- if progress_bufnr and api.nvim_buf_is_valid(progress_bufnr) then
    --     api.nvim_buf_delete(progress_bufnr, { force = true })
    -- end
    progress_winid = nil
    -- progress_bufnr = nil -- Keep bufnr if we want to quickly reopen and update
end


return M
