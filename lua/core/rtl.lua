-- RTL Support Module
local M = {}

function M.setup()
  -- Toggle RTL mode with <leader>rtl
  vim.keymap.set("n", "<leader>rtl", function()
    vim.opt.rl = not vim.opt.rl:get()
    local status = vim.opt.rl:get() and "Enabled" or "Disabled"
    vim.notify("RTL Mode: " .. status, vim.log.levels.INFO, { title = "NvPak" })
  end, { desc = "Toggle Persian RTL mode" })
end

return M
