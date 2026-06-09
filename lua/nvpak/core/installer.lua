-- NvPak Core Installer Module
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

function utils.command_exists(cmd) return vim.fn.executable(cmd) == 1 end

function utils.info(msg) vim.api.nvim_echo({ { "INFO: ", "Bold" }, { msg, "None" } }, true, {}) end
function utils.success(msg) vim.api.nvim_echo({ { "SUCCESS: ", "Bold" }, { msg, "Green" } }, true, {}) end

function M.init()
    utils.info("NvPak Professional Installer started.")
    M.install_plugins()
    if vim.v.headless == 1 then vim.cmd("qall!") end
end

function M.install_plugins()
    local ok, rocks = pcall(require, "rocks")
    if ok and rocks.sync then
        rocks.sync()
        utils.success("Plugins synced.")
    end
end

function M.cli_refresh_plugins() M.install_plugins() end
function M.cli_fetch_nvpak()
    local config_dir = vim.fn.stdpath("config")
    vim.fn.system({ "git", "-C", config_dir, "pull" })
    utils.success("NvPak source updated.")
end

return M
