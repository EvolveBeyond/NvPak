-- Arabic/Persian (RTL) Support
local M = {}
function M.setup()
  vim.keymap.set("n", "<leader>rtl", function()
    local opt = vim.opt
    -- Use modern 'rightleft' with 'rl' as alias fallback (deprecated but still works)
    local current = opt.rightleft:get() or opt.rl:get()
    opt.rightleft = not current
    local status = opt.rightleft:get() and "Enabled" or "Disabled"
    vim.notify("RTL Mode: " .. status, vim.log.levels.INFO, { title = "NvPak" })
  end, { desc = "Toggle Persian RTL mode" })
end
return M
