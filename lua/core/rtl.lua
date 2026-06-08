-- Arabic/Persian (RTL) Support Configuration

local M = {}

function M.setup()
  -- Toggle RTL/LTR mode
  vim.keymap.set("n", "<leader>rtl", function()
    vim.opt.rl = not vim.opt.rl:get()
    if vim.opt.rl:get() then
        print("Right-to-Left Mode: Enabled")
    else
        print("Right-to-Left Mode: Disabled")
    end
  end, { desc = "Toggle RTL mode (Persian/Arabic)" })

  -- Ensure keymap for Arabic is available if needed
  -- vim.opt.keymap = "arabic" -- Uncomment if you want default arabic keymap

  -- Fix for Konsole and other modern terminals regarding RTL
  -- Note: Most terminal emulators handle BiDi themselves, but Neovim's 'rightleft'
  -- helps with alignment in the buffer.
end

return M
