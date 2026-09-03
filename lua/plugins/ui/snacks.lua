local M = {}

local HEADER = [[
███╗   ██╗██╗   ██╗██████╗  █████╗ ██╗  ██╗
████╗  ██║██║   ██║██╔══██╗██╔══██╗██║  ██║
██╔██╗ ██║██║   ██║██████╔╝███████║███████║
██║╚██╗██║╚██╗ ██╔╝██╔═══╝ ██╔══██║██╔══██║
██║ ╚████║ ╚████╔╝ ██║     ██║  ██║██║  ██║
╚═╝  ╚═══╝  ╚═══╝  ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝
]]

function M.config()
  local snacks = require("snacks")
  snacks.setup({
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = HEADER,
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header", padding = 1 },
        { section = "keys", gap = 1, padding = 1 },
        { section = "recent_files", indent = 2, padding = 1, title = "Recent Files" },
        { section = "projects", indent = 2, padding = 1, title = "Projects" },
        { section = "startup" },
      },
    },
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
