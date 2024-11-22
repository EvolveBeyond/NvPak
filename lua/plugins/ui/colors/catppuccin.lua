require("catppuccin").setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	background = { -- :h background
		light = "latte",
		dark = "mocha",
	},
	transparent_background = false,
  show_end_of_buffer = true,
	term_colors = true,
	dim_inactive = {
		enabled = false,
		shade = "dark",
		percentage = 0.15,
	},
  no_italic = false,
  no_bold = false,
	styles = {
		comments = { "italic" },
    conditionals = { "bold", "italic" },
    loops = { "bold" },
    functions = { "bold", "italic" },
    keywords = { "italic" },
    strings = { "italic" },
	},
	color_overrides = {},
  custom_highlights = {
    Normal = { bg = "#1e1e2e" },
    Comment = { fg = "#6c7086", style = { "italic" } },
    Error = { fg = "#f38ba8", style = { "bold" } },
  },
	integrations = {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		telescope = true,
    notify = true,
		mini = false,
  },
})

-- Auto-detect background and switch flavors dynamically
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    local flavour = vim.o.background == "dark" and "mocha" or "latte"
    require("catppuccin").setup({ flavour = flavour })
    vim.cmd.colorscheme("catppuccin")
  end,
})

-- Load colorscheme
vim.cmd.colorscheme("catppuccin")
