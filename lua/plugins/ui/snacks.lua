local M = {}

function M.config()
  local snacks = require("snacks")

  snacks.setup({
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  })

  -- Keybindings for snacks
  vim.keymap.set("n", "<leader>un", function() snacks.notifier.show_history() end, { desc = "Notification History" })
  vim.keymap.set("n", "<leader>bd", function() snacks.bufdelete() end, { desc = "Delete Buffer" })
  vim.keymap.set("n", "<leader>gg", function() snacks.lazygit() end, { desc = "Lazygit" })
end

return M
