<p align="center">
  <img width="256" height="256" src="https://user-images.githubusercontent.com/27810360/190279839-f6685b5f-4c56-41b3-b1b5-a8768cc52fb6.gif">
</p>

<div align="center">

[![APACHEv3 license](https://img.shields.io/badge/License-APACHEv2-red.svg?style=flat-square)](https://github.com/Pakrohk-DotFiles/NvPak/blob/main/LICENSE)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg?style=flat-square)](https://github.com/Pakrohk-DotFiles/NvPak/graphs/commit-activity)
[![Neovim Minimum Version](https://img.shields.io/badge/Neovim-0.10.0-blueviolet.svg?style=flat-square&logo=Neovim&color=90E59A&logoColor=white)](https://github.com/neovim/neovim)
[![Maintainer](https://img.shields.io/badge/maintainer-theMaintainer-blue?style=flat-square)](https://github.com/Pakrohk)
[![GitHub Issues](https://img.shields.io/github/issues/pakrohk-dotfiles/NvPak.svg?style=flat-square&label=Issues&color=d77982)](https://github.com/Pakrohk-DotFiles/NvPak/issues)

# What is the purpose of the NvPak project? ✨

Maybe you have tried to configure Neovim multiple times over the past few years. Neovim has undergone many changes, and every time, you had to follow new defaults to reach the minimum configuration and start writing your configuration for Neovim. The goal of the nvpak project is to provide these defaults.

Now you can configure only what you need by forking nvpak without any add-ons. Please note that nvpak is not a Neovim configuration and not in competition with other configurations such as NvChad or LazyVim. If you need a complete Neovim setup without any configuration, then this GitHub repository is not for you.

# Why is the name of the project NvPak? 🌟

"nv" stands for Neovim and "Pak" is derived from the Persian word "پاک" meaning "clean," which represents brightness and simplicity, contrary to complexity and disorder.

**Update 2026 (Zen Modernization):** The project has been fully modernized for 2026, embracing a deeper "Zen" approach with high-performance tools like `blink.cmp` and `snacks.nvim` while adding first-class support for Persian (RTL).

</div>

## Requirements 📋

To ensure the installation scripts and NvPak work correctly, please have the following:

- **Operating System:**
  - Linux (most distributions)
  - macOS
  - Windows 10/11 (with PowerShell 5.1+)
  - Android (via Termux)
- **Core Tools:**
  - `git`
  - `curl`
  - `unzip`
  - `neovim v0.10.0` or later (for native Treesitter folding and modern plugin compatibility)
- **Shell:**
  - `bash` or `dash` for Unix-like systems.
  - `PowerShell v5.1` or later for Windows.
- **Recommended Tools:**
  - `ripgrep` & `fd` (for high-speed search)
  - Clipboard tools: `xclip`/`wl-clipboard` (Linux), `pbcopy` (macOS), `win32yank` (Windows)
- **Nerd Fonts & Persian Support:**
  - For the best experience, we recommend **Vazirmatn RD Nerd Font** or any font that supports both Persian glyphs and Nerd Font icons.

### Screenshots 📷

<details>
<summary>
Show
</summary>
<br>

![full](https://user-images.githubusercontent.com/27810360/215935940-81f0b59b-9382-4915-a395-f6903f07c1a8.png)
![autocompelet](https://user-images.githubusercontent.com/27810360/215936237-96bc8604-1597-4aa9-bbfb-4709cae73016.png)
![NeoVide](https://user-images.githubusercontent.com/27810360/181910971-43f34b7f-116a-4981-a9d6-37db0c1526f1.png)

</details>

# Modern 2026 Stack 🚀

NvPak has been rebuilt with performance and simplicity in mind:

- **[blink.cmp](https://github.com/Saghen/blink.cmp):** A lightning-fast completion engine.
- **[snacks.nvim](https://github.com/folke/snacks.nvim):** A consolidated solution for dashboard, notifications, indentation, and more, replacing multiple heavy plugins.
- **Native Folding:** Leverages Neovim 0.10+ native Treesitter folding for a smoother editing experience.
- **Persian RTL:** Built-in RTL support. Use `<leader>rtl` to toggle Right-to-Left mode. Optimized for Konsole/Plasma environments.

# Installation 💻

## Linux / macOS / Android (Termux)
```bash
curl -sS https://raw.githubusercontent.com/Pakrohk-DotFiles/NvPak/main/install.sh | bash
```

## Windows (Native PowerShell)
```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Pakrohk-DotFiles/NvPak/main/install.ps1" -OutFile "install.ps1"; .\install.ps1
```

# Usage 🚀

- **Plugin Management:** Powered by [rocks.nvim](https://github.com/nvim-neorocks/rocks.nvim).
    - `:Rocks sync` - Synchronize plugins with `rocks.toml`.
    - `:Rocks install <plugin>` - Install a new plugin.
- **Snacks Features:**
    - `<leader>un` - Notification History.
    - `<leader>bd` - Delete current buffer.
    - `<leader>gg` - Lazygit.
- **RTL Toggle:**
    - `<leader>rtl` - Toggle Persian/Arabic RTL mode.

# Contributing 🤝

We welcome contributions! Fork the repository, make your changes, and submit a pull request. Please ensure your commit messages are in English and follow the "Pak" philosophy.

---
**Maintainer:** [Pakrohk](https://github.com/Pakrohk)
