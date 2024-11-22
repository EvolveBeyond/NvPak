local blackline = require("ibl")
local hooks = require "ibl.hooks"

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

-- Reset highlight groups on colorscheme change
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  local colors = {
    RainbowRed = "#E06C75",
    RainbowYellow = "#E5C07B",local treesitte = require("nvim-treesitter.configs")

-- Default languages for installation
local default_languages = { "python", "bash", "dart", "rust", "lua" }
local user_languages = vim.g.user_extra_treesitter_languages or {}

treesitte.setup({
  ensure_installed = vim.tbl_extend("force", default_languages, user_languages),
  sync_install = true, -- Install languages synchronously

  highlight = {
    enable = true, -- Enable syntax highlighting
    additional_vim_regex_highlighting = false, -- Avoid duplicate highlights
  },

  indent = {
    enable = true, -- Enable indentation
    disable = { "python" }, -- Disable for Python due to conflicts
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn", -- Initialize selection
      node_incremental = "grn", -- Increment to next node
      node_decremental = "grm", -- Decrement to previous node
      scope_incremental = "grc", -- Increment scope
    },
  },

  rainbow = {
    enable = true, -- Enable rainbow parentheses
    extended_mode = true, -- Highlight non-bracket delimiters
    max_file_lines = 1000, -- Disable for large files
  },

  context_commentstring = {
    enable = true, -- Enable context-aware commenting
    enable_autocmd = false, -- Use only with explicit configuration
  },
})

    RainbowBlue = "#61AFEF",
    RainbowOrange = "#D19A66",
    RainbowGreen = "#98C379",
    RainbowViolet = "#C678DD",
    RainbowCyan = "#56B6C2",
  }

  -- Create or update highlight groups
  for group, color in pairs(colors) do
    local success, _ = pcall(vim.api.nvim_set_hl, 0, group, { fg = color })
    if not success then
      vim.notify("Failed to set highlight for " .. group, vim.log.levels.WARN)
    end
  end
end)

-- Configure Indent Blankline (ibl) with rainbow colors for indentation and scope
blackline.setup({
  indent = {
    highlight = highlight, -- Apply rainbow colors to indent lines
  },
        scope = {
    enabled = true,       -- Enable scope highlighting
    highlight = highlight, -- Use rainbow colors for scope lines
        },
})

-- Ensure scope highlighting uses extmarks, but skip unsupported buffers
hooks.register(hooks.type.SCOPE_HIGHLIGHT, function(bufnr)
  if not vim.treesitter.highlighter.active[bufnr] then
    vim.notify("Scope highlighting skipped: Treesitter not active for buffer " .. bufnr, vim.log.levels.INFO)
    return
  end
  hooks.builtin.scope_highlight_from_extmark(bufnr)
end)

-- Add command to toggle scope highlighting dynamically
vim.api.nvim_create_user_command("IblToggleScope", function()
  blackline.setup({ scope = { enabled = not blackline.scope.enabled } })
  vim.notify("Indent Blankline scope " .. (blackline.scope.enabled and "enabled" or "disabled"))
end, {})
