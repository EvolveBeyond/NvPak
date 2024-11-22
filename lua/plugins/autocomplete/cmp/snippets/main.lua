-- Load VS Code snippets with lazy loading for specific filetypes
require("luasnip.loaders.from_vscode").lazy_load({
  include = { 'python', 'html', 'django' }, -- Only load for specific languages
  exclude = { 'javascript', 'css' },        -- Exclude unnecessary languages
})

-- Define Django snippet for Python and HTML files
local DJANGO = "djangohtml"
local snippets = {
	python = { "django" },
	html = { DJANGO, "html" },
	htmldjango = { DJANGO, "html" }, -- for files with .html and .django extension
}

-- Extend filetypes with Django-specific snippets
for filetype, snips in pairs(snippets) do
	require("luasnip").filetype_extend(filetype, snips)
end
