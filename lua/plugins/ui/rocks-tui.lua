local M = {}

function M.config()
  require("rocks-tui").setup({
    -- Professional UI for Rocks management
    ui = {
      manager_window = {
        border = "rounded",
        width_ratio = 0.8,
      }
    }
  })

  vim.keymap.set("n", "<leader>rp", ":RocksTUI<CR>", { desc = "Rocks TUI Manager" })
end

return M
