require'cmp'.setup {
 sources = {
 	{ name = 'cmp_tabnine' },
 },
}
local tabnine = require('cmp_tabnine.config')
tabnine:setup({
	sort = true;
	run_on_every_keystroke = true;
	snippet_placeholder = '..';
	ignored_file_types = { -- default is not to ignore
		-- uncomment to ignore in lua:
		-- lua = true
	};
	show_prediction_strength = true;
})
