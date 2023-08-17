local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    -- notification plugin
    require("packages.ui.nvim-notify"),
    -- autocompeletion plugins
    -- The goal of nvim-treesitter is both to provide a simple and easy way to use the interface for tree-sitter in Neovim and to provide some basic functionality such as highlighting based on it
    require("packages.nvim-treesitter"),
    -- This plugin adds indentation guides to all lines (including empty lines).
    require("packages.nvim-treesitter.indent"),
    -- lsp plugins
    require("packages.autocomplete.lspconfig"),
    -- complate menu plugins
    require("packages.autocomplete.cmp"),
    -- bracket autocompletion
    require("packages.autocomplete.cmp.autopairs"),
    -- Debugging System
    require("packages.autocomplete.dap"),
    -- vim diagnostics system
    require("packages.autocomplete.lsp_lines"),
    require("packages.autocomplete.trouble"),
    -- Fuzzy Finder
    require("packages.telescope"),
    -- Icons
    require("packages.ui.devicons"),
    -- Tree File Explorer
    require("packages.ui.nvim-tree"),
    -- Neovim Terminal
    require("packages.ui.nvim-terminal"),
    -- Themes and more customize Plugins
    -- Dashboard
    require("packages.ui.dashboard"),
    -- barabr TabLine
    require("packages.ui.barbar"),
    -- lua Statusline
    require("packages.ui.lualine"),
    -- show HexCode Colors
    require("packages.ui.HexColor"),
    -- colorschemes and syntax highlighting
    require("packages.colors"),
}

local opt = {
    defaults = {
        lazy = false, -- should plugins be lazy-loaded?
        version = nil,
        -- version = "*", -- enable this to try installing the latest stable versions of plugins
    },
    -- leave nil when passing the spec as the first argument to setup()
    spec = nil,                                               -- @type LazySpec
    lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", -- lockfile generated after running update.
    concurrency = 2,                                          -- @type number limit the maximum amount of concurrent tasks
    git = {
        -- defaults for the `Lazy log` command
        -- log = { "-10" }, -- show the last 10 commits
        log = { "--since=3 days ago" }, -- show commits from the last 3 days
        timeout = 120,                  -- kill processes that take more than 2 minutes
        url_format = "https://github.com/%s.git",
        -- lazy.nvim dependencies git >=2.19.0. If you really want to use lazy with an older version,
        -- then set the below to false. This is should work, but is NOT supported and will
        -- increase downloads a lot.
        filter = true,
    },
    -- dev = {
    -- directory where you store your local plugin projects
    -- path = "~/projects",
    -- @type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
    -- patterns = {}, -- For example {"folke"}
    -- fallback = false, -- Fallback to git when local plugin doesn't exist
    -- },
    install = {
        -- install missing plugins on startup. This doesn't increase startup time.
        missing = true,
        -- try to load one of these colorschemes when starting an installation during startup
        colorscheme = { "habamax" },
    },
    ui = {
        wrap = true,   -- wrap the lines in the ui
        throttle = 20, -- how frequently should the ui process render events
    },
    checker = {
        -- automatically check for plugin updates
        enabled = true,
        concurrency = 4,  -- @type number? set to 1 to check for updates very slowly
        notify = true,    -- get a notification when new updates are found
        frequency = 3600, -- check for updates every hour
    },
    change_detection = {
        -- automatically check for config file changes and reload the ui
        enabled = false,
        notify = true, -- get a notification when changes are found
    },
    performance = {
        cache = {
            enabled = true,
        },
        reset_packpath = true, -- reset the package path to improve startup time
        --  rtp = {
        --  	reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
        --  	---@type string[]
        --  	paths = {}, -- add any custom paths here that you want to includes in the rtp
        --  	---@type string[] list any plugins you want to disable here
        --  	disabled_plugins = {
        --  		-- "gzip",
        --  		-- "matchit",
        --  		-- "matchparen",
        --  		-- "netrwPlugin",
        --  		-- "tarPlugin",
        --  		-- "tohtml",
        --  		-- "tutor",
        --  		-- "zipPlugin",
        --  	},
        --  },
    },
    -- lazy can generate helptags from the headings in markdown readme files,
    -- so :help works even for plugins that don't have vim docs.
    -- when the readme opens with :help it will be correctly displayed as markdown
    readme = {
        root = vim.fn.stdpath("state") .. "/lazy/readme",
        files = { "README.md", "lua/**/README.md" },
        -- only generate markdown helptags for plugins that dont have docs
        skip_if_doc_exists = true,
    },
}

require("lazy").setup(plugins, opt)
