local M = {}

function M.config()
  require('blink.cmp').setup({
    keymap = { preset = 'default' },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono'
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    completion = {
      list = { selection = { preselect = false, auto_insert = true } },
      menu = { border = 'rounded' },
      documentation = { auto_show = true, window = { border = 'rounded' } },
    },
    signature = { enabled = true, window = { border = 'rounded' } }
  })
end

return M
