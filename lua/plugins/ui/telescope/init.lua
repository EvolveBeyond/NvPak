-- Unified Telescope Bundle Config
local M = {}

function M.config()
  require("telescope").setup({
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {}
      }
    }
  })
  pcall(require("telescope").load_extension, "ui-select")
end

return M
