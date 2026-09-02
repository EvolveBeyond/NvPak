-- nvpak.core.installer — CLI backend for scripts/nvpak.ps1
-- Exposes cli_* functions invoked headlessly:
--   nvim --headless -u init.lua -c "lua require('nvpak.core.installer').cli_x(args)"
-- Each function reports results, then schedules nvim to exit with code 0
-- (errors are reported as messages, not non-zero exits, matching PS1 handling).

local M = {}

local function notify(msg, level)
    vim.notify(msg, level or vim.log.levels.INFO, { title = "NvPak CLI" })
end

local function report_ok(msg)
    notify(msg, vim.log.levels.INFO)
end

local function report_err(msg)
    notify(msg, vim.log.levels.ERROR)
end

-- Exit nvim after the current event-loop turn so messages flush in headless mode.
local function schedule_exit()
    vim.schedule(function()
        vim.cmd("redraw")
        vim.cmd("qall!")
    end)
end

-- Resolve the rocks.nvim API, loading it lazily if this runs before rocks bootstraps.
local function get_rocks()
    local ok, rocks = pcall(require, "rocks.api")
    if ok and rocks then
        return rocks
    end
    return nil
end

local function has_rocks_commands()
    return vim.fn.exists(":Rocks") == 2
end

-- Never let a Rocks command error propagate: it would skip schedule_exit()
-- and hang headless nvim with no qall!. Catch and report instead.
local function run_rocks_cmd(cmd)
    if has_rocks_commands() then
        local ok, err = pcall(vim.cmd, cmd)
        if not ok then
            report_err("Rocks command failed ':" .. cmd .. "': " .. tostring(err))
            return false
        end
        return true
    end
    report_err("rocks.nvim is not loaded; cannot run ':" .. cmd .. "'. Run ':Rocks sync' manually inside nvim.")
    return false
end

--- cli_install_package("user/repo" | "plugin-name" | "name==version")
function M.cli_install_package(spec)
    if type(spec) ~= "string" or #spec == 0 then
        report_err("cli_install_package: missing plugin spec")
        schedule_exit()
        return
    end
    report_ok("Installing: " .. spec)
    if run_rocks_cmd("Rocks install " .. spec) then
        report_ok("Install finished: " .. spec)
    end
    schedule_exit()
end

--- cli_uninstall_package("plugin-name")
function M.cli_uninstall_package(name)
    if type(name) ~= "string" or #name == 0 then
        report_err("cli_uninstall_package: missing plugin name")
        schedule_exit()
        return
    end
    report_ok("Uninstalling: " .. name)
    if run_rocks_cmd("Rocks uninstall " .. name) then
        report_ok("Uninstall finished: " .. name)
    end
    schedule_exit()
end

--- cli_update_package("plugin-name")
function M.cli_update_package(name)
    if type(name) ~= "string" or #name == 0 then
        report_err("cli_update_package: missing plugin name")
        schedule_exit()
        return
    end
    report_ok("Updating: " .. name)
    if run_rocks_cmd("Rocks update " .. name) then
        report_ok("Update finished: " .. name)
    end
    schedule_exit()
end

--- cli_upgrade_all_packages()
function M.cli_upgrade_all_packages()
    report_ok("Upgrading all rocks...")
    if run_rocks_cmd("Rocks update") then
        report_ok("Upgrade finished.")
    end
    schedule_exit()
end

--- cli_refresh_plugins()
function M.cli_refresh_plugins()
    report_ok("Syncing plugins with rocks.toml...")
    if run_rocks_cmd("Rocks sync") then
        report_ok("Sync finished.")
    end
    schedule_exit()
end

--- cli_fetch_nvpak()
-- Pulls the latest NvPak config from the repo backing the running config dir.
function M.cli_fetch_nvpak()
    local config_dir = vim.fn.stdpath("config")
    report_ok("Fetching NvPak updates in " .. config_dir)
    local out = vim.fn.system({ "git", "-C", config_dir, "pull", "--ff-only" })
    local rc = vim.v.shell_error
    if rc == 0 then
        report_ok("NvPak is up to date.")
    else
        report_err("git pull failed (exit " .. rc .. "):\n" .. out)
    end
    schedule_exit()
end

-- Support direct invocation: nvim -c "lua require('nvpak.core.installer').run({...})"
-- kept for manual testing without the PS1 wrapper.
function M.run(fn_name, args)
    local f = M[fn_name]
    if type(f) ~= "function" then
        report_err("Unknown NvPak CLI function: " .. tostring(fn_name))
        schedule_exit()
        return
    end
    f(args)
end

return M
