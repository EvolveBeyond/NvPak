local Bind = vim.keymap.set

-- Define key mappings for Trouble
local trouble_mappings = {
  { "n", "<leader>xx", "<cmd>TroubleToggle<cr>" },
  { "n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>" },
  { "n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>" },
  { "n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>" },
  { "n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>" },
  { "n", "gR", "<cmd>TroubleToggle lsp_references<cr>" },
}

for _, map in ipairs(trouble_mappings) do
  Bind(map[1], map[2], map[3], { silent = true, noremap = true })
end

-- Define action keys for Trouble
local function setup_trouble_keys()
  local action_keys = {
    close = "q", -- close the list
    cancel = "<esc>", -- cancel the preview
    refresh = "r", -- manually refresh
    jump = { "<cr>", "<tab>" }, -- jump or toggle fold
    open_split = { "<c-x>" }, -- open in new split
    open_vsplit = { "<c-v>" }, -- open in new vsplit
    open_tab = { "<c-t>" }, -- open in new tab
    jump_close = { "o" }, -- jump and close list
    toggle_mode = "m", -- toggle workspace/document diagnostics
    toggle_preview = "P", -- toggle auto-preview
    hover = "K", -- show details popup
    preview = "p", -- preview diagnostic location
    close_folds = { "zM", "zm" }, -- close all folds
    open_folds = { "zR", "zr" }, -- open all folds
    toggle_fold = { "zA", "za" }, -- toggle fold of current file
    previous = "k", -- go to previous item
    next = "j", -- go to next item
  }
  return action_keys
end

return setup_trouble_keys()
