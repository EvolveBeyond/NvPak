local M = {}

function M.config()
  local blink = require("blink.cmp")

  blink.setup({
    keymap = { preset = "default" },

    appearance = {
      nerd_font_variant = "mono"
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    signature = { enabled = true }
  })
end

return M
