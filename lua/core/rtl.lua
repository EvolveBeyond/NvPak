-- Persian/Arabic (RTL) Support Module
local M = {}

---Toggle RTL mode in Neovim
function M.toggle()
    vim.opt.rl = not vim.opt.rl:get()
    local status = vim.opt.rl:get() and "Enabled" or "Disabled"
    vim.notify("RTL Mode: " .. status, vim.log.levels.INFO, { title = "NvPak" })
end

---Initial setup for RTL support
function M.setup()
    -- RTL settings are already in basic.lua as defaults for compatibility
    -- This setup can be used for auto-commands or other RTL-specific logic
end

return M
