# rocks-tui.nvim

**A Terminal User Interface (TUI) for `rocks.nvim` to enhance Neovim plugin management.**

`rocks-tui.nvim` (or simply `rocks-tui`) provides an interactive and visual way to manage your Neovim plugins when using the [`rocks.nvim`](https://github.com/nvim-neorocks/rocks.nvim) package manager. It aims to simplify common plugin management tasks like discovery, installation, updates, and removal, drawing inspiration from user-friendly package manager interfaces.

## Features

- **Plugin Manager View:**
    - List installed plugins with their versions and status.
    - Update individual plugins or all plugins.
    - Remove plugins.
    - Trigger `:Rocks sync` to synchronize with your `rocks.toml`.
    - Quickly view `rocks.nvim` logs.
- **Plugin Search View:**
    - Search for new plugins (interactively prompts for query).
    - Display search results with plugin names and descriptions.
    - Install plugins directly from the search results (with optional version specification).
- **Installation Progress View:**
    - Visualize the progress of plugin installations and updates.
    - Shows current operation, overall progress bar, and detailed status (conceptual, relies on `rocks.nvim` providing data).
- **Configurable:**
    - Customize key mappings for all TUI windows.
    - Adjust basic UI elements like window borders, sizes (as ratios), and titles.
- **Built with Lua and Neovim API:** Leverages floating windows and other Neovim UI primitives.

## Prerequisites

- [Neovim](https://neovim.io/) (Version 0.8+ recommended, 0.10+ for best compatibility with underlying APIs)
- [`rocks.nvim`](https://github.com/nvim-neorocks/rocks.nvim) installed and configured in your Neovim setup.

## Installation

Once this plugin is published to a repository accessible by `rocks.nvim` (e.g., LuaRocks or a community repository):

```vim
:Rocks install your-repo-user/rocks-tui.nvim
```
(Replace `your-repo-user/rocks-tui.nvim` with the actual rock name.)

For local development or testing:
1. Clone this repository:
   ```sh
   git clone https://github.com/your-username/rocks-tui.nvim.git somewhere/rocks-tui.nvim
   ```
2. Add it to your Neovim runtime path. For example, if using a packer-like structure or manually managing paths:
   Ensure `somewhere/rocks-tui.nvim` is in your `&runtimepath`.

## Basic Usage

The plugin provides several commands to access its features:

- **`:RocksTUI`**: Opens the main plugin manager window. Here you can see your installed plugins and manage them.
- **`:RocksTUISearch`**: Opens the plugin search interface. Enter a query to find new plugins.
- **`:RocksTUIProgress`**: Manually opens the installation progress window. This window also attempts to open automatically during installations initiated by `rocks-tui`.
- **`:RocksTUISetup`**: Allows you to re-apply your configuration (useful for testing changes without restarting Neovim).

Refer to the help file (`:help rocks-tui`) for detailed information on key mappings within each window.

## Configuration

You can customize `rocks-tui` by calling the `setup` function in your Neovim configuration (e.g., `init.lua` or a dedicated plugin configuration file).

```lua
require('rocks-tui').setup({
  -- ui = {
  --   manager_window = {
  --     border = "single", -- "none", "single", "double", "rounded", "solid", "shadow"
  --     width_ratio = 0.75,
  --     title = "My Plugin Manager"
  --   },
  --   search_window = {
  --     border = "solid",
  --   }
  -- },
  -- keymaps = {
  --   manager_close = "<Esc>",
  --   manager_refresh = "R",
  --   search_install_selected = "<CR>",
  --   progress_close = "<C-c>",
  -- }
})
```

If `setup()` is not called, the plugin will use its default configuration.
See `:help rocks-tui-default-configuration` for the full list of default options.

## Current Status & Limitations

- **Search Functionality:** The current search results are based on placeholder data within `core.lua`. Full integration with `rocks.nvim`'s search capabilities (e.g., parsing `:Rocks search <query>` output or using a Lua API if available) is needed for actual plugin discovery.
- **Progress Visualization:** The progress UI is functional, but the data feeding into it from `core.lua` is conceptual (simulated). Real-time progress updates depend on `rocks.nvim` providing events or a detailed API for progress, or on more complex wrapping of `rocks.nvim` commands.
- **Error Handling:** Basic error handling is in place, but can be made more robust.
- **Modularity:** The plugin is designed with modularity in mind, but further refinements can always be made.

## Contributing

Contributions are welcome! If you have ideas for improvements, new features, or bug fixes, please feel free to open an issue or submit a pull request.

## License

This plugin is licensed under [LICENSE_TYPE_HERE - e.g., MIT, GPLv3]. (Developer: Please choose and add a license file).
