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

To ensure the installation scripts and NvPak work correctly, please have the following:

- **Operating System:**
  - Linux (most distributions)
  - macOS
  - Windows 10/11 (with PowerShell 5.1+)
  - Android (via Termux)
- **Core Tools (the scripts will attempt to install these if missing):**
  - `git`
  - `curl`
  - `unzip`
  - `neovim v0.8.0` or later (the script aims for the latest stable version)
- **Shell:**
  - `bash` or `dash` for Unix-like systems (Linux, macOS, Termux, Git Bash on Windows).
  - `PowerShell v5.1` or later for the native Windows installation script.
- **Recommended for full functionality (the scripts will attempt to install these):**
  - `ripgrep` (for Telescope live grep)
  - `fd` (alternative for Telescope)
  - Clipboard tools:
    - Linux: `xclip` or `xsel` (Xorg), `wl-clipboard` (Wayland)
    - macOS: `pbcopy`/`pbpaste` (built-in)
    - Windows: Handled by Neovim/win32yank (often auto-installed or installable via `scoop install win32yank`)
    - Termux: `termux-api` (for `termux-clipboard-get`/`set`)
  - `pynvim` (if you are a Python developer)
- **For Windows Native Installation:**
  - `Scoop.sh` package manager. The script can help you install it.
- **Important for UI:**
  - **Nerd Fonts:** Install a [Nerd Font](https://www.nerdfonts.com/) and set it as your terminal's font for proper icon display.

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

NvPak provides automated installation scripts for various operating systems.

## Prerequisites

Before running the installation scripts, ensure you have:
- **Internet connection:** To download dependencies and the NvPak repository.
- **Permissions:** You might need administrative/sudo rights to install some packages.

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
    The script will attempt to detect your OS and package manager to install all necessary dependencies, clone/update NvPak to `~/.config/nvim` (or `$XDG_CONFIG_HOME/nvim`), and guide you through the final steps.

## Windows (Native PowerShell)

1.  **Open PowerShell as Administrator.** This is highly recommended to ensure Scoop and other dependencies can be installed or configured correctly.
2.  **Set Execution Policy (if needed):**
    If you haven't run PowerShell scripts from the internet before, you might need to allow script execution for the current user:
    ```powershell
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    ```
3.  **Download and run the installer:**
    ```powershell
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Pakrohk-DotFiles/NvPak/main/install.ps1" -OutFile "install.ps1"
    .\install.ps1
    ```
    The script will use Scoop to install dependencies (it will offer to install Scoop itself if not found), clone/update NvPak to `~\AppData\Local\nvim`, and prepare Neovim for first use.
    *Note: If Scoop is installed for the first time by the script, you will be prompted to open a new PowerShell window and re-run `.\install.ps1` for the PATH changes (especially for Scoop itself) to take effect.*

## Post-Installation Steps

After the script finishes:
1.  **Nerd Fonts:** Crucial for UI icons. Ensure you have a [Nerd Font](https://www.nerdfonts.com/) installed and **set as your terminal's font**. The installation script will remind you, but the font configuration is manual.
2.  **First Neovim Run:** The installation script will attempt to run Neovim once (often headlessly) to finalize plugin installations via `rocks.nvim`. You might see messages from `rocks.nvim` about installing plugins. Please wait for this process to complete. If you open Neovim manually for the first time, this process will also occur.
3.  **Restart Terminal (Recommended):** After new tools are installed (especially by Scoop or system package managers), it's a good idea to restart your terminal or source your shell's configuration file (e.g., `.bashrc`, `.zshrc`) for all PATH changes to apply.

# Usage 🚀

Once NvPak is installed:

1.  **Open Neovim:**
    ```bash
    nvim
    ```
2.  **Plugin Management (with rocks.nvim):**
    NvPak uses [rocks.nvim](https://github.com/nvim-neorocks/rocks.nvim) for plugin management, defined in the `rocks.toml` file.
    - Plugins are automatically installed or updated by `rocks.nvim` when Neovim starts if there are changes to `rocks.toml` or if new plugins are added.
    - The installation script already triggers this initial plugin setup.
    - You generally don't need to manually sync plugins. However, if you modify `rocks.toml` or want to force a sync/update, you can use commands within Neovim:
        - `:Rocks sync` - Installs any missing plugins, updates plugins marked as `scm` or those with newer version constraints.
        - `:Rocks update [<plugin_name>]` - Updates a specific plugin or all plugins to their latest allowed versions.
        - `:Rocks clean` - Removes any installed plugins that are no longer listed in `rocks.toml`.
        - `:Rocks build [<plugin_name>]` - To rebuild a specific plugin if needed.
    - Refer to the `rocks.nvim` documentation for more commands and details.

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





