-- NvPak Core Installer Module
-- Handles dependency checks, plugin installation, and initial setup.

local M = {}

-- Placeholder for utility functions (OS detection, command execution, etc.)
local utils = {}

--- Detects the current operating system.
--- @return string "windows", "linux", "macos", or "unknown"
function utils.get_os()
    local uname = vim.loop.os_uname()
    if not uname then return "unknown" end
    if uname.sysname == "Windows_NT" then return "windows" end
    if uname.sysname == "Linux" then return "linux" end
    if uname.sysname == "Darwin" then return "macos" end
    return "unknown"
end

--- Checks if a command exists.
--- @param cmd string The command to check.
--- @return boolean true if the command exists, false otherwise.
function utils.command_exists(cmd)
    return vim.fn.executable(cmd) == 1
end

--- Prints an informational message.
--- @param msg string The message to print.
function utils.info(msg)
    vim.api.nvim_echo({ { "INFO: ", "Bold" }, { msg, "None" } }, true, {})
end

--- Prints a success message.
--- @param msg string The message to print.
function utils.success(msg)
    vim.api.nvim_echo({ { "SUCCESS: ", "Bold" }, { msg, "Green" } }, true, {})
end

--- Prints a warning message.
--- @param msg string The message to print.
function utils.warning(msg)
    vim.api.nvim_echo({ { "WARNING: ", "Bold" }, { msg, "Yellow" } }, true, {})
end

--- Prints an error message.
--- @param msg string The message to print.
function utils.error_msg(msg)
    vim.api.nvim_echo({ { "ERROR: ", "Bold" }, { msg, "Red" } }, true, {})
end


--- Main function called by the shell installer scripts.
function M.init()
    utils.info("NvPak Lua Installer started.")
    utils.info("Detected OS: " .. utils.get_os())

    -- 1. Check and install secondary dependencies
    M.check_secondary_dependencies()

    -- 2. Nerd Fonts Guidance
    M.guide_nerd_fonts()

    -- 3. Plugin Installation (using rocks.nvim)
    -- This will likely involve calling functions from your rocks.nvim setup
    M.install_plugins()

    -- 4. Offer initial setup options (plugin profiles) - Future step
    -- M.offer_setup_profiles()

    utils.success("NvPak Lua Installer finished basic setup.")
    utils.info("You might need to restart Neovim for all changes to take effect.")
    utils.info("Run ':checkhealth' to verify your setup after restarting.")

    -- For now, we quit after running. This might change if we want interactive prompts.
    -- If running truly headless and no more interaction is needed:
    if vim.v.headless == 1 then
        vim.cmd("qall!")
    end
end

--- Checks and guides installation of secondary dependencies.
function M.check_secondary_dependencies()
    utils.info("Checking secondary dependencies...")
    local os = utils.get_os()

    -- Example: ripgrep (rg)
    if not utils.command_exists("rg") then
        utils.warning("ripgrep (rg) is not installed. This is highly recommended for Telescope search.")
        if os == "linux" then
            utils.info("On Linux, you can often install it with: sudo apt install ripgrep / sudo yum install ripgrep / sudo dnf install ripgrep / sudo pacman -S ripgrep")
        elseif os == "macos" then
            utils.info("On macOS, you can install it with: brew install ripgrep")
        elseif os == "windows" then
            utils.info("On Windows, you can install it with Scoop: scoop install ripgrep")
        end
    else
        utils.success("ripgrep (rg) is installed.")
    end

    -- Example: fd
    if not utils.command_exists("fd") then
        utils.warning("fd is not installed. This is a useful alternative for Telescope.")
        if os == "linux" then
            utils.info("On Linux, you can often install it with: sudo apt install fd-find / sudo yum install fd-find / sudo dnf install fd-find / sudo pacman -S fd")
            utils.info("Note: On some systems, the binary might be 'fdfind'. You may need to create a symlink 'fd' to 'fdfind'.")
        elseif os == "macos" then
            utils.info("On macOS, you can install it with: brew install fd")
        elseif os == "windows" then
            utils.info("On Windows, you can install it with Scoop: scoop install fd")
        end
    else
        utils.success("fd is installed.")
    end

    -- TODO: Add checks for pynvim, clipboard tools based on OS
    -- For pynvim:
    M.check_pynvim(os)

    -- For clipboard tools:
    M.check_clipboard_tools(os)
end

--- Checks for pynvim and Python 3.
--- @param os string Current OS ("windows", "linux", "macos")
function M.check_pynvim(os)
    utils.info("Checking for pynvim (Python 3 integration)...")
    local python_exe = "python3"
    if os == "windows" then
        -- On Windows, 'python' might be Python 3, or 'py -3' could be more reliable
        -- For simplicity, we'll try 'python3' first, then 'python'
        if not utils.command_exists("python3") and utils.command_exists("python") then
            python_exe = "python"
        elseif not utils.command_exists("python3") and utils.command_exists("py") then
             -- Check if py -3 works
            local py3_check_cmd = { "py", "-3", "-c", "import sys; sys.exit(0)" }
            local _, py3_exit_code = vim.fn.system(py3_check_cmd)
            if py3_exit_code == 0 then
                python_exe = "py -3" -- Found a working Python 3 launcher
            else
                 utils.warning("python3 not found, and 'py -3' does not seem to work.")
            end
        end
    end

    if not utils.command_exists(python_exe:match("^[^%s]+")) then -- Get the base command for existence check
        utils.warning(python_exe .. " (Python 3) is not installed or not in PATH.")
        utils.info("pynvim requires Python 3. Please install Python 3.")
        if os == "linux" then
            utils.info("On Linux, install with: sudo apt install python3 python3-pip / sudo yum install python3 python3-pip ...")
        elseif os == "macos" then
            utils.info("On macOS, install with: brew install python")
        elseif os == "windows" then
            utils.info("On Windows, download from https://www.python.org/ or install with Scoop: scoop install python")
        end
        return
    end

    local pip_exe = python_exe:gsub("python", "pip"):gsub("py", "pip") -- python3 -> pip3, python -> pip, py -3 -> pip -3 (approx)
     if python_exe == "py -3" then pip_exe = "py -3 -m pip" end -- More robust for py launcher

    if not utils.command_exists(pip_exe:match("^[^%s]+")) and not (python_exe == "py -3") then -- pip might not be separate for 'py'
         -- Attempt to see if pip module is available via python_exe -m pip
        local pip_check_cmd = vim.split(python_exe .. " -m pip --version", " ")
        local _, pip_via_module_exit_code = vim.fn.system(pip_check_cmd)
        if pip_via_module_exit_code ~= 0 then
            utils.warning(pip_exe .. " (pip for Python 3) is not installed or not in PATH.")
            utils.info("pynvim is installed using pip. Please ensure pip for Python 3 is installed.")
            if os == "windows" and python_exe ~= "py -3" then
                utils.info("Often, ensuring Python from python.org is installed and 'Scripts' directory is in PATH fixes this.")
                utils.info("Or run: " .. python_exe .. " -m ensurepip --upgrade")
            end
            return
        else
            pip_exe = python_exe .. " -m pip" -- Use this form if direct pipX command failed
        end
    end


    -- Check if pynvim is importable
    -- Using a temp file to avoid issues with quotes in system() command
    local check_script_path = vim.fn.stdpath("cache") .. "/check_pynvim.py"
    vim.fn.writefile({ "import pynvim" }, check_script_path)
    local pynvim_check_cmd = vim.split(python_exe .. " " .. vim.fn.shellescape(check_script_path), " ")

    utils.info("Verifying pynvim installation with: " .. table.concat(pynvim_check_cmd, " "))
    local _, exit_code = vim.fn.system(pynvim_check_cmd)
    vim.loop.fs_unlink(check_script_path) -- Clean up temp file

    if exit_code == 0 then
        utils.success("pynvim is installed and importable with " .. python_exe)
    else
        utils.warning("pynvim module is not importable with " .. python_exe)
        utils.info("Attempting to install/upgrade pynvim using: " .. pip_exe .. " install --user --upgrade pynvim")
        local install_cmd = vim.split(pip_exe .. " install --user --upgrade pynvim", " ")
        -- Running pip install. This can take time.
        -- Consider if this should be truly headless or provide more feedback.
        local _, pip_exit_code = vim.fn.system(install_cmd)
        if pip_exit_code == 0 then
            utils.success("pynvim installed/upgraded successfully via pip.")
            utils.info("Please restart Neovim for Python plugins to work correctly.")
        else
            utils.error_msg("Failed to install pynvim using pip. Exit code: " .. pip_exit_code)
            utils.info("Please try installing it manually: " .. pip_exe .. " install --user --upgrade pynvim")
        end
    end
end

--- Checks for clipboard tools.
--- @param os string Current OS ("windows", "linux", "macos")
function M.check_clipboard_tools(os)
    utils.info("Checking for clipboard tools...")
    if os == "linux" then
        local wayland = vim.env.WAYLAND_DISPLAY ~= nil
        local needed = ""
        if wayland then
            if not utils.command_exists("wl-copy") or not utils.command_exists("wl-paste") then
                needed = "wl-clipboard"
            end
        else -- X11
            if not utils.command_exists("xclip") and not utils.command_exists("xsel") then
                needed = "xclip or xsel"
            end
        end
        if needed ~= "" then
            utils.warning(needed .. " not found. Clipboard integration might not work.")
            utils.info("On Linux, install with: sudo apt install " .. needed .. " / sudo yum install " .. needed .. " ...")
        else
            utils.success("Suitable clipboard tool (wl-clipboard, xclip, or xsel) found for Linux.")
        end
    elseif os == "macos" then
        if utils.command_exists("pbcopy") and utils.command_exists("pbpaste") then
            utils.success("pbcopy/pbpaste found for macOS clipboard integration.")
        else
            utils.warning("pbcopy/pbpaste not found on macOS. This is unusual. Clipboard will not work.")
        end
    elseif os == "windows" then
        -- Neovim often bundles win32yank or it's expected to be handled.
        -- We can check for win32yank if user wants to ensure it via Scoop.
        if not utils.command_exists("win32yank") then
            utils.info("win32yank.exe not found in PATH. Neovim might use an internal version or fallback.")
            utils.info("For optimal clipboard on Windows, especially in WSL or terminals, consider installing win32yank:")
            utils.info("scoop install win32yank")
        else
            utils.success("win32yank found. Clipboard should work.")
        end
    end
end

--- Guides the user for Nerd Fonts installation.
function M.guide_nerd_fonts()
    utils.info("--- Nerd Fonts ---")
    utils.info("For the best visual experience with icons and symbols, a Nerd Font is highly recommended.")
    utils.info("1. Download a Nerd Font of your choice from: https://www.nerdfonts.com/font-downloads")
    utils.info("2. Install the font on your system (instructions vary by OS).")
    utils.info("3. Configure your terminal emulator to use the installed Nerd Font.")
    utils.info("Popular choices include: FiraCode Nerd Font, JetBrainsMono Nerd Font, Hack Nerd Font.")
end

--- Handles plugin installation using rocks.nvim.
function M.install_plugins()
    utils.info("Starting plugin installation via rocks.nvim...")
    -- This assumes rocks.nvim is already set up by your NvPak's init.lua
    -- and that it might have an API to trigger installation or synchronization.

    -- Example: If rocks.nvim has a function to sync/install all plugins
    -- This is a HYPOTHETICAL example. You need to replace this with actual rocks.nvim API calls.
    -- pcall(function()
    --     local rocks_api = require("rocks") -- Or however you access rocks
    --     if rocks_api and rocks_api.sync then
    --         utils.info("Calling rocks.nvim sync...")
    --         local ok, result = rocks_api.sync() -- Or install, or bootstrap
    --         if ok then
    --             utils.success("rocks.nvim sync completed.")
    --             if result then vim.print(result) end
    --         else
    --             utils.error_msg("rocks.nvim sync failed: " .. tostring(result))
    --         end
    --     else
    --         utils.warning("Could not find rocks.nvim API for plugin installation. Manual setup might be needed.")
    --         utils.info("Typically, plugins are installed when Neovim starts with the new configuration.")
    --     end
    -- end)

    -- This assumes rocks.nvim is already set up by NvPak's init.lua
    -- and that it uses lazy.nvim as its backend.
    -- NvPak's init.lua (or a file it requires, like lua/plugins/init.lua which calls lua/plugins/rocks.lua)
    -- should have already called require("lazy").setup(...).

    local lazy_ok, lazy = pcall(require, "lazy")

    if not lazy_ok or not lazy then
        utils.error_msg("Failed to load lazy.nvim. Ensure it is correctly bootstrapped by your NvPak configuration (init.lua).")
        utils.info("Plugin installation cannot proceed without lazy.nvim.")
        return
    end

    utils.info("Attempting to synchronize plugins with lazy.nvim...")

    -- The `lazy.sync()` function checks for missing plugins, installs them,
    -- and cleans up removed plugins. It's suitable for this installer script.
    -- It can also take options, but default behavior should be fine here.
    local sync_ok, result = pcall(lazy.sync, {
        -- We might want to ensure it doesn't prompt if running headless,
        -- though lazy.nvim is generally good about headless operation.
        -- Example options (check lazy.nvim docs for actual available options for sync):
        -- notify = false, -- if we want to suppress notifications here and show our own
        -- install = { missing = true }, -- ensure missing plugins are installed
        -- update = { all = false }, -- don't update all, just sync
        -- clean = true, -- clean up removed plugins
    })

    if sync_ok then
        utils.success("lazy.nvim sync process completed.")
        if type(result) == "table" and result.updated and #result.updated > 0 then
             utils.info("Number of plugins updated/installed: " .. #result.updated)
        elseif type(result) == "table" and result.installed and #result.installed > 0 then
             utils.info("Number of plugins installed: " .. #result.installed)
        else
            utils.info("No new plugins were installed or updated by lazy.sync, or no detailed result returned.")
        end
        -- vim.print(result) -- Could be verbose, use with caution or extract specific info
    else
        utils.error_msg("lazy.nvim sync process failed.")
        utils.error_msg("Error details: " .. tostring(result))
        utils.info("Plugins might not be fully installed. Check your configuration and try ':Lazy sync' manually in Neovim.")
    end

    -- Optionally, run health check for lazy if available
    if lazy.health then
        utils.info("Running lazy.nvim health check...")
        -- This might be too verbose for an installer, but good for debugging
        -- local health_ok, health_result = pcall(lazy.health)
        -- if health_ok and health_result then
        --    utils.info("Lazy health check results:")
        --    vim.print(health_result)
        -- end
    end

    utils.success("Plugin installation/synchronization step finished.")
end

-- Placeholder for future CLI-related functions
function M.cli_install_package(plugin_spec)
    utils.info("CLI: Request to install plugin: " .. plugin_spec)
    utils.warning("Automated installation via CLI by modifying plugin configuration files is complex and not yet fully implemented.")
    utils.info("Please manually add the plugin spec to your NvPak plugin configuration (e.g., rocks.toml or Lua files).")
    utils.info("After adding, you can try 'nvpak refresh' or run :Lazy sync in Neovim.")
    -- As a fallback, we can attempt a sync, which might pick up changes if user manually edited files.
    M.try_lazy_sync("Plugin installation requested. Attempting to sync with lazy.nvim.")
end

function M.try_lazy_sync(reason_message)
    utils.info(reason_message)
    local lazy_ok, lazy = pcall(require, "lazy")
    if not lazy_ok or not lazy then
        utils.error_msg("lazy.nvim module not found. Cannot perform sync.")
        return false
    end
    local ok, result = pcall(lazy.sync)
    if ok then
        utils.success("lazy.nvim sync completed.")
        -- utils.info(vim.inspect(result)) -- Can be verbose
        return true
    else
        utils.error_msg("lazy.nvim sync failed: " .. tostring(result))
        return false
    end
end

function M.cli_update_package(packageName)
    utils.info("CLI: Request to update plugin: " .. packageName)
    local lazy_ok, lazy = pcall(require, "lazy")
    if not lazy_ok or not lazy then
        utils.error_msg("lazy.nvim module not found. Cannot update plugin.")
        return
    end

    utils.info("Attempting to update '" .. packageName .. "' with lazy.nvim...")
    -- lazy.update() can take a plugin name or nil (for all)
    -- It also takes options, like `notify = true/false`
    local ok, result = pcall(lazy.update, packageName)
    if ok then
        utils.success("lazy.nvim update process for '" .. packageName .. "' initiated.")
        -- utils.info(vim.inspect(result)) -- Result might indicate if updates were found/applied
        utils.info("Check Neovim notifications or :Lazy interface for update details.")
    else
        utils.error_msg("lazy.nvim update command failed for '" .. packageName .. "': " .. tostring(result))
    end
end

function M.cli_upgrade_all_packages()
    utils.info("CLI: Request to upgrade all installed plugins.")
    local lazy_ok, lazy = pcall(require, "lazy")
    if not lazy_ok or not lazy then
        utils.error_msg("lazy.nvim module not found. Cannot upgrade plugins.")
        return
    end

    utils.info("Attempting to update all plugins with lazy.nvim...")
    local ok, result = pcall(lazy.update) -- No argument means update all
    if ok then
        utils.success("lazy.nvim update process for all plugins initiated.")
        -- utils.info(vim.inspect(result))
        utils.info("Check Neovim notifications or :Lazy interface for update details.")
    else
        utils.error_msg("lazy.nvim update command for all plugins failed: " .. tostring(result))
    end
end

function M.cli_uninstall_package(packageName)
    utils.info("CLI: Request to uninstall plugin: " .. packageName)
    utils.warning("Automated uninstallation via CLI by modifying plugin configuration files is complex and not yet fully implemented.")
    utils.info("Please manually remove the plugin spec from your NvPak plugin configuration (e.g., rocks.toml or Lua files).")
    utils.info("After removing, you can try 'nvpak refresh' or run :Lazy sync (which also cleans) in Neovim.")
    M.try_lazy_sync("Plugin uninstallation requested. Attempting to sync/clean with lazy.nvim.")
end

function M.cli_refresh_plugins()
    utils.info("CLI: Request to refresh plugin list and sync.")
    M.try_lazy_sync("Refreshing plugins as requested by CLI.")
end

function M.cli_fetch_nvpak()
    utils.info("CLI: Request to fetch NvPak updates (git pull)")
    local config_dir = vim.fn.stdpath("config")
    local cmd = { "git", "-C", config_dir, "pull" }
    utils.info("Running: " .. table.concat(cmd, " "))
    local job_id = vim.fn.jobstart(cmd, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_exit = function(_, code, _)
            if code == 0 then
                utils.success("NvPak updated successfully from git.")
                vim.cmd("redraw!") -- Redraw to show messages
            else
                utils.error_msg("Failed to update NvPak from git. Exit code: " .. code)
                local stderr = vim.fn.jobgetstderr(job_id)
                if stderr and #stderr > 0 then
                    utils.error_msg("Git stderr:")
                    for _, line in ipairs(stderr) do
                        if line ~= "" then utils.error_msg(line) end
                    end
                end
                vim.cmd("redraw!")
            end
            -- If running from CLI, this exit might be too soon or not needed
            -- if vim.v.headless == 1 and not M._is_cli_call then vim.cmd("qall!") end
        end,
    })
    if not job_id or job_id == 0 or job_id == -1 then
        utils.error_msg("Failed to start git pull job.")
    end
end

return M
