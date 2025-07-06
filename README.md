<p align="center">
  <img width="256" height="256" src="https://user-images.githubusercontent.com/27810360/190279839-f6685b5f-4c56-41b3-b1b5-a8768cc52fb6.gif">
</p>

<div align="center">

[![APACHEv3 license](https://img.shields.io/badge/License-APACHEv2-red.svg?style=flat-square)](https://github.com/Pakrohk-DotFiles/NvPak/blob/main/LICENSE)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg?style=flat-square)](https://github.com/Pakrohk-DotFiles/NvPak/graphs/commit-activity)
[![Neovim Minimum Version](https://img.shields.io/badge/Neovim-0.8.0-blueviolet.svg?style=flat-square&logo=Neovim&color=90E59A&logoColor=white)](https://github.com/neovim/neovim)
[![Maintainer](https://img.shields.io/badge/maintainer-theMaintainer-blue?style=flat-square)](https://github.com/Pakrohk)
[![GitHub Issues](https://img.shields.io/github/issues/pakrohk-dotfiles/NvPak.svg?style=flat-square&label=Issues&color=d77982)](https://github.com/Pakrohk-DotFiles/NvPak/issues)

# What is the purpose of the NvPak project? ✨

Maybe you have tried to configure Neovim multiple times over the past few years. Neovim has undergone many changes, and every time, you had to follow new defaults to reach the minimum configuration and start writing your configuration for Neovim. The goal of the nvpak project is to provide these defaults.

Now you can configure only what you need by forking nvpak without any add-ons. Please note that nvpak is not a Neovim configuration and not in competition with other configurations such as NvChad or LazyVim. If you need a complete Neovim setup without any configuration, then this GitHub repository is not for you.

# Why is the name of the project NvPak? 🌟

"nv" stands for Neovim and "Pak" is derived from the Persian word "پاک" meaning "clean," which represents brightness and simplicity, contrary to complexity and disorder. 

</div>

## Requirements 📋

To ensure NvPak installs and works correctly, please have the following:

- **Operating System:**
  - Linux (most distributions)
  - macOS
  - Windows 10/11 (with PowerShell 5.1+ for the installer)
  - Android (via Termux, using the Linux installer)
- **Core Prerequisites (the main `install.sh` or `install.ps1` scripts will attempt to install these):**
  - `git` (version 2.19.0+ recommended for some plugin manager features)
  - `neovim v0.8.0` or later (LuaJIT build required)
- **Shell:**
  - `bash` (or a compatible shell like `zsh`, `dash`) for Unix-like systems.
  - `PowerShell v5.1` or later for the native Windows installation script (`install.ps1`).
- **Recommended for full functionality (the NvPak Lua installer will guide you or check for these):**
  - `ripgrep` (for Telescope live grep and other search functionalities)
  - `fd` (a fast alternative to `find`, used by Telescope)
  - Clipboard tools:
    - Linux: `xclip` or `xsel` (for X11), `wl-clipboard` (for Wayland)
    - macOS: `pbcopy`/`pbpaste` (usually built-in)
    - Windows: `win32yank` (installable via `scoop install win32yank`; Neovim might have fallbacks)
  - `pynvim` (Python 3 bindings for Neovim, if you are a Python developer)
- **For Windows Native Installation (`install.ps1`):**
  - `Scoop.sh` package manager is highly recommended. The script will offer to install it if not found.
- **Crucial for UI:**
  - **Nerd Fonts:** To display icons and symbols correctly, you **must** install a [Nerd Font](https://www.nerdfonts.com/font-downloads) and configure your terminal emulator to use it. Popular choices include FiraCode Nerd Font, JetBrainsMono Nerd Font, and Hack Nerd Font. The Lua installer will remind you about this.

### Screenshots 📷

<details>
<summary>
Show
</summary>
<br>



![full](https://user-images.githubusercontent.com/27810360/215935940-81f0b59b-9382-4915-a395-f6903f07c1a8.png)

![autocompelet](https://user-images.githubusercontent.com/27810360/215936237-96bc8604-1597-4aa9-bbfb-4709cae73016.png)

![NeoVide](https://user-images.githubusercontent.com/27810360/181910971-43f34b7f-116a-4981-a9d6-37db0c1526f1.png)

![Fuzzy Finder](https://user-images.githubusercontent.com/48873115/217238383-51c83389-ef78-414c-bdda-2896033ce389.png)

![CmdLine](https://user-images.githubusercontent.com/27810360/181955593-80e4480b-e158-4be7-abe0-0509072d1118.png)

![show error and warns details](https://user-images.githubusercontent.com/27810360/215936761-4ec5c34c-789e-426f-91a4-dca3b6b2a7d1.png)

</details>

# Installation 💻

NvPak provides streamlined installation scripts that handle core dependencies and then delegate to an internal Lua-based installer for further setup.

**General Prerequisites for Installation Scripts:**
- **Internet connection:** Required to download dependencies and the NvPak repository.
- **Permissions:** You might need administrative/sudo rights to install system-level packages like Git or Neovim if they are not already present.

## Linux / macOS / Android (Termux) / Unix-like shells on Windows (Git Bash, WSL)

1.  **Download the installer:**
    ```bash
    curl -LO https://raw.githubusercontent.com/Pakrohk-DotFiles/NvPak/main/install.sh
    ```
    *(If `curl` is not available, you can download `install.sh` manually from the repository.)*
2.  **Make it executable:**
    ```bash
    chmod +x install.sh
    ```
3.  **Run the installer:**
    ```bash
    ./install.sh
    ```
    This script will:
    - Attempt to detect your OS and package manager.
    - Ensure `git` and `neovim` are installed, prompting for installation if missing.
    - Clone or update NvPak to `~/.config/nvim` (or `$XDG_CONFIG_HOME/nvim`).
    - Launch Neovim headlessly to run the NvPak Lua installer, which will:
        - Check for recommended secondary dependencies (like `ripgrep`, `fd`, `pynvim`, clipboard tools) and guide you if any are missing.
        - Guide you on installing Nerd Fonts.
        - Synchronize and install all configured plugins using `lazy.nvim` (via `rocks.nvim`).

## Windows (Native PowerShell)

1.  **Open PowerShell.** Running as Administrator is recommended if you anticipate needing to install Scoop or other system-level tools.
2.  **Set Execution Policy (if needed):**
    If you haven't run PowerShell scripts from the internet before, you might need to allow script execution:
    ```powershell
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    ```
3.  **Download and run the installer:**
    ```powershell
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Pakrohk-DotFiles/NvPak/main/install.ps1" -OutFile "install.ps1"
    .\install.ps1
    ```
    This script will:
    - Offer to install `Scoop.sh` if it's not found (Scoop is used to install `git` and `neovim`).
    - Ensure `git` and `neovim` are installed.
    - Clone or update NvPak to `~\AppData\Local\nvim`.
    - Launch Neovim headlessly to run the NvPak Lua installer (with the same responsibilities as mentioned in the Linux section).
    *Note: If Scoop is installed for the first time by the script, you will be prompted to open a new PowerShell window and re-run `.\install.ps1` for the PATH changes to take effect.*

## Post-Installation Essentials

1.  **Nerd Fonts:** This is crucial for a proper UI experience with icons. If you haven't already, install a [Nerd Font](https://www.nerdfonts.com/font-downloads) and **set it as your terminal's display font**. The Lua installer will remind you, but the font configuration in your terminal is a manual step.
2.  **Restart Terminal (Recommended):** Especially if new tools like Neovim, Git, or Scoop were installed, restarting your terminal ensures all PATH changes are correctly applied.

# Usage 🚀

Once NvPak is installed, simply open Neovim:
```bash
nvim
```
All configured plugins should be installed and ready to use.

## Managing NvPak with the `nvpak` CLI

NvPak now includes a command-line interface (CLI) tool named `nvpak` to help you manage your NvPak installation and plugins from outside Neovim.

**Setup for `nvpak` CLI:**

The installer scripts (`install.sh`/`install.ps1`) do not automatically add the `nvpak` CLI scripts to your system's PATH. You'll need to do this manually for now, or you can run them directly by specifying their path. The CLI scripts are located in the `scripts/` directory of your NvPak installation (`$NVIM_CONFIG_DIR/scripts/`).

**Recommended: Add to PATH**
1.  Choose one of the following methods:
    *   **Symlink:** Create symbolic links to `nvpak.sh` (and `nvpak.ps1` for Windows PowerShell users) in a directory that is already in your PATH (e.g., `~/.local/bin` on Linux/macOS).
        ```bash
        # For Linux/macOS (assuming ~/.local/bin is in your PATH)
        mkdir -p ~/.local/bin
        ln -sfn "$HOME/.config/nvim/scripts/nvpak.sh" "$HOME/.local/bin/nvpak"
        ```
        For PowerShell, you might add the `scripts` directory to your `$env:Path` or create an alias.
    *   **Copy:** Copy `nvpak.sh` and `nvpak.ps1` to a directory in your PATH.
    *   **Add NvPak's `scripts` directory to PATH:** Add `$HOME/.config/nvim/scripts` (or equivalent) to your shell's configuration file (e.g., `.bashrc`, `.zshrc`, PowerShell Profile).

**CLI Commands:**

*   `nvpak help`: Displays the help message with all available commands.
*   `nvpak install <plugin-spec>`:
    *   **Note:** Fully automated installation by modifying configuration files is complex and **not yet implemented**.
    *   This command will currently guide you to manually add the plugin to your NvPak plugin configuration (e.g., `rocks.toml` or relevant Lua files).
    *   After manual addition, run `nvpak refresh` to synchronize.
*   `nvpak uninstall <plugin-name>`:
    *   **Note:** Similar to `install`, fully automated uninstallation is **not yet implemented**.
    *   This command will guide you to manually remove the plugin from your configuration.
    *   After manual removal, run `nvpak refresh` to synchronize and clean.
*   `nvpak update [plugin-name]`: Updates a specific plugin if `plugin-name` is provided, or all installed plugins if no name is given.
*   `nvpak upgrade`: A convenient alias to update all installed plugins.
*   `nvpak refresh`: Synchronizes your plugin state with `lazy.nvim` based on your current configuration. Use this after manually adding or removing plugins from your config files.
*   `nvpak fetch`: Fetches the latest updates for NvPak itself from its Git repository (i.e., runs `git pull` in the NvPak directory).

**CLI Aliases:**

You can define short aliases for `nvpak` commands.
1.  Create the alias configuration file:
    *   Linux/macOS: `~/.config/nvpak/aliases.conf` (or `$XDG_CONFIG_HOME/nvpak/aliases.conf`)
    *   Windows: `~\AppData\Local\nvpak\aliases.conf`
2.  Add aliases in the format `alias_name=command_name`. Example:
    ```ini
    # Example aliases.conf
    in=install
    rm=uninstall
    up=update
    ug=upgrade
    sy=refresh # sy for sync
    fp=fetch   # fp for fetch pak
    ```
    An example file `scripts/nvpak_aliases.conf.example` is provided in the NvPak repository.

## Plugin Management within Neovim (via rocks.nvim & lazy.nvim)

NvPak uses [rocks.nvim](https://github.com/nvim-neorocks/rocks.nvim) which in turn utilizes [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management. Plugins are primarily defined in `rocks.toml`.
- `lazy.nvim` automatically installs missing plugins and updates them based on the lockfile (`lazy-lock.json`) or plugin specifications during startup.
- You can also manage plugins from within Neovim using `lazy.nvim` commands:
    - `:Lazy` or `:Lazyui`: Opens the `lazy.nvim` user interface.
    - `:Lazy sync`: Synchronizes plugins (installs missing, cleans unused).
    - `:Lazy update [plugin_name]`: Updates plugins.
    - Refer to the `lazy.nvim` documentation for more commands.

Enjoy your clean and powerful Neovim setup!

# Contributing 🤝


If you're interested in contributing to the project, we welcome your help in fixing bugs and adding new features.\
 Here's how you can get started:
 
Check the [Projects](https://github.com/EvolveBeyond/NvPak/projects) section to see if there are any open issues or features that you'd like to work on. \
If you have an idea for a new feature or improvement, feel free to suggest it and discuss it with the [NvPak](https://github.com/EvolveBeyond/NvPak) team.

Fork the NvPak repository to your own GitHub account.\
Make your changes and commit them to your forked repository. Please make sure to follow the project's coding standards and best practices, and write clear and concise commit messages.

Submit a pull request from your forked repository to the main NvPak repository.\
 Your changes will be reviewed by the NvPak team, who may provide feedback and request changes if necessary.\
Once your changes are approved, they will be merged into the main NvPak repository and will be available to all users.

By contributing to NvPak, you'll be helping to improve the project for all users, and you'll have the opportunity to learn and collaborate with other developers.

 Thank you for considering contributing to NvPak!

 
you can find the list of contributors on the [contributors page](https://github.com/nooob-developer/NvPak/graphs/contributors).


## Team
<a href="https://github.com/EvolveBeyond/nvpak/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=EvolveBeyond/nvpak" />
</a>





