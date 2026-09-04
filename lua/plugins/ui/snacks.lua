local M = {}

-- NvPak Home (lua/nvpak/home) is the primary dashboard / default landing page.
-- Snacks is used for its supporting modules only (notifier, input, etc.),
-- not as a dashboard replacement.

function M.config()
  local snacks = require("snacks")
  snacks.setup({
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    indent = { enabled = true, scope = { enabled = true } },
    input = { enabled = true },
    notifier = { enabled = true, style = "compact" },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  })

  local map = vim.keymap.set
  map("n", "<leader>.", function() snacks.scratch() end, { desc = "Toggle Scratch Buffer" })
  map("n", "<leader>un", function() snacks.notifier.show_history() end, { desc = "Notification History" })
  map("n", "<leader>bd", function() snacks.bufdelete() end, { desc = "Delete Buffer" })
  map("n", "<leader>gg", function() snacks.lazygit() end, { desc = "Lazygit" })
  map("n", "<leader>fb", function() snacks.picker.buffers() end, { desc = "Find Buffers" })
  map("n", "<leader>ff", function() snacks.picker.files() end, { desc = "Find Files" })
  map("n", "<leader>fg", function() snacks.picker.grep() end, { desc = "Live Grep" })
  map("n", "<leader>fh", function() snacks.picker.help() end, { desc = "Help Tags" })
end

return M
