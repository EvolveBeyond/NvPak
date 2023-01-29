-- Load friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load({
    include = nil, -- Load all languages
    exclude = {},
})

-- config for Django
require("luasnip").filetype_extend("python", { "django" })
require("luasnip").filetype_extend("html", { "djangohtml", "html" })
require("luasnip").filetype_extend("htmldjango", { "djangohtml", "html" })
