local ok, trouble = pcall(require, "trouble")
if not ok then
  vim.notify("Trouble plugin not found", vim.log.levels.ERROR)
  return
end

local hotkeys = require("plugins.autocomplete.trouble.bind")

trouble.setup({
  position = "bottom", -- position of the list
  height = 10, -- height when bottom/top
  width = 50, -- width when left/right
  icons = true, -- use devicons
  mode = "workspace_diagnostics", -- default mode
  fold_open = "", -- icon for open folds
  fold_closed = "", -- icon for closed folds
  group = true, -- group by file
  padding = true, -- extra new line on top
  action_keys = hotkeys.action_keys, -- custom action keys
  indent_lines = true, -- indent guides
  auto_open = false, -- auto-open on diagnostics
  auto_close = false, -- auto-close on no diagnostics
  auto_preview = true, -- auto-preview diagnostic locations
  auto_fold = false, -- auto-fold file lists
  auto_jump = { "lsp_definitions" }, -- jump on single result
  signs = {
    error = "",
    warning = "",
    hint = "",
    information = "",
    other = "﫠",
  },
  use_diagnostic_signs = false, -- use LSP signs
})
