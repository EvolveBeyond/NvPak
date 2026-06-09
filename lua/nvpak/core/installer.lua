-- NvPak Core Installer (rocks.nvim compatible)
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
    M.check_secondary_dependencies()
    M.install_plugins()
    if vim.v.headless == 1 then vim.cmd("qall!") end
end

function M.check_secondary_dependencies()
    local os = utils.get_os()
    local deps = { "rg", "fd", "git", "curl" }
    for _, dep in ipairs(deps) do
        if utils.command_exists(dep) then
            utils.success(dep .. " is installed.")
        else
            vim.api.nvim_echo({ { "WARNING: ", "Bold" }, { dep .. " is missing.", "Yellow" } }, true, {})
        end
    end
end

function M.install_plugins()
    local ok, rocks = pcall(require, "rocks")
    if ok and rocks.sync then
        utils.info("Syncing plugins with rocks.nvim...")
        rocks.sync()
    else
        vim.api.nvim_echo({ { "WARNING: ", "Bold" }, { "rocks.nvim not initialized yet. Skipping sync.", "Yellow" } }, true, {})
    end
end

return M
