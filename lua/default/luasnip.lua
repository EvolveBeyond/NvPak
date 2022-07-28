-- Load friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()
-- config for Django
require'luasnip'.filetype_extend("python", {"django"})
require'luasnip'.filetype_extend("html", {"djangohtml"})
