-- NvPak Core Installer Module
-- Handles dependency checks, plugin installation, and initial setup using rocks.nvim.

local M = {}

local utils = {}

function utils.get_os()
    local uname = vim.loop.os_uname()
    if not uname then return "unknown" end
    if uname.sysname == "Windows_NT" then return "windows" end
    if uname.sysname == "Linux" then return "linux" end
    if uname.sysname == "Darwin" then return "macos" end
    return "unknown"
end

function utils.command_exists(cmd)
    return vim.fn.executable(cmd) == 1
end

function utils.info(msg)
    vim.api.nvim_echo({ { "INFO: ", "Bold" }, { msg, "None" } }, true, {})
end

function utils.success(msg)
    vim.api.nvim_echo({ { "SUCCESS: ", "Bold" }, { msg, "Green" } }, true, {})
end

function utils.warning(msg)
    vim.api.nvim_echo({ { "WARNING: ", "Bold" }, { msg, "Yellow" } }, true, {})
end

function utils.error_msg(msg)
    vim.api.nvim_echo({ { "ERROR: ", "Bold" }, { msg, "Red" } }, true, {})
end

function M.init()
    utils.info("NvPak Professional Installer started.")
    M.check_secondary_dependencies()
    M.install_plugins()
    if vim.v.headless == 1 then
        vim.cmd("qall!")
    end
end

function M.check_secondary_dependencies()
    local os = utils.get_os()
    local deps = { "rg", "fd", "git", "curl" }
    for _, dep in ipairs(deps) do
        if utils.command_exists(dep) then
            utils.success(dep .. " is installed.")
        else
            utils.warning(dep .. " is missing.")
        end
    end
end

function M.install_plugins()
    utils.info("Syncing plugins with rocks.nvim...")
    local ok, rocks = pcall(require, "rocks")
    if ok and rocks.sync then
        rocks.sync()
        utils.success("Plugins synced successfully.")
    else
        utils.warning("rocks.nvim not found or API changed. Skipping sync.")
    end
end

-- CLI adaptors for rocks.nvim
function M.cli_refresh_plugins()
    M.install_plugins()
end

function M.cli_fetch_nvpak()
    local config_dir = vim.fn.stdpath("config")
    vim.fn.system({ "git", "-C", config_dir, "pull" })
    utils.success("NvPak source updated.")
end

return M
