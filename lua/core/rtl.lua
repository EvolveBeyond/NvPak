-- Arabic/Persian (RTL) Support

local M = {}

function M.setup()
  -- Toggle RTL mode
  vim.keymap.set("n", "<leader>rtl", function()
    vim.opt.rl = not vim.opt.rl:get()
    print("RTL Mode: " .. (vim.opt.rl:get() and "Enabled" or "Disabled"))
  end, { desc = "Toggle RTL (Persian)" })
end

return M
