local M = {}

function M.config()
  local ok, hover = pcall(require, "hover")
  if not ok then
    vim.notify("hover.nvim not installed. Run :Rocks sync", vim.log.levels.WARN)
    return
  end

  hover.config({
    providers = {
      "hover.providers.lsp",
      "hover.providers.diagnostic",
    },
    preview_opts = {
      border = "rounded",
    },
    title = true,
    mouse_providers = {
      "hover.providers.lsp",
    },
    mouse_delay = 1000,
  })

  vim.keymap.set("n", "K", hover.open, { noremap = true, silent = true, desc = "Hover documentation" })
  vim.keymap.set("n", "gK", hover.select, { noremap = true, silent = true, desc = "Hover (select provider)" })
end

return M
