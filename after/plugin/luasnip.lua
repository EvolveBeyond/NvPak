-- Load friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load({
	include = nil, -- Load all languages
	exclude = {},
})

-- config for Django
require'luasnip'.filetype_extend("python", {"django"})
require'luasnip'.filetype_extend("html", {"djangohtml", "html"})
require'luasnip'.filetype_extend("htmldjango", {"djangohtml", "html"})

-- vim-vsnip config
local server_specific_opts = {
  sumneko_lua = function(opts)
    opts.settings = {
      Lua = {
        -- NOTE: This is required for expansion of lua function signatures!
        completion = {callSnippet = "Replace"},
        diagnostics = {
          globals = {'vim'},
        },
      },
    }
  end,

  html = function(opts)
    opts.filetypes = {"html", "htmldjango"}
  end,
  htmldjango = function (opts)
    opts.filetypes = {"html", "htmldjango"}
  end,
}
