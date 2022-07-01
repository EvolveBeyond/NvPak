  local home = os.getenv('HOME')
  local db = require('dashboard')
  db.preview_command = 'cat | lolcat -F 0.3'
  db.session_directory = home .. '/.cache/nvim/session'
  db.preview_file_path = home .. '/.config/nvim/logo.cat'
  db.preview_file_height = 12
  db.preview_file_width = 80
  db.custom_center = {
	{
		icon = "  ",
		desc = "New file                               ",
		shortcut = ":enew",
		action = "enew",
	},
	{
		icon = "  ",
		desc = "Find file                              ",
		shortcut = "SPC f",
		action = "Telescope find_files hidden=true no_ignore=true",
	},
	{
		icon = "  ",
		desc = "Browse dotfiles                        ",
		shortcut = "SPC v d",
		action = "Telescope find_files cwd=~/.config/nvim/ search_dirs=Ultisnips,lua,viml,init.vim",
	},
	{
		icon = "  ",
		desc = "UpdatePlugins                         ",
		shortcut = "SPC p s",
		action = "PackerSync",
	},
	{
		icon = "  ",
		desc = "Open floating terminal                 ",
		shortcut = "SPC t t",
		action = "FloatermToggle",
	},
	{
		icon = "  ",
		desc = "Close neovim                           ",
		shortcut = ":qa!",
		action = "qa!",
	},
}
