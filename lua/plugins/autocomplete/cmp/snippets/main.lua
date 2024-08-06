-- Load snippets from VS Code
require("luasnip.loaders.from_vscode").lazy_load({
	include = nil, -- Load all languages
	exclude = {},
})

-- Define Django snippet for Python and HTML files
local DJANGO = "djangohtml"
local snippets = {
	python = { "django" },
	html = { DJANGO, "html" },
	htmldjango = { DJANGO, "html" }, -- for files with .html and .django extension
}

-- Extend file types with snippets
for filetype, snips in pairs(snippets) do
	require("luasnip").filetype_extend(filetype, snips)
end
