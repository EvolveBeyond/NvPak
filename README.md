# NvPak: Professional & Modern Neovim (2026)

NvPak is a minimalist, high-performance Neovim configuration following the "Pak" philosophy: clean, modular, and extremely fast.

[![Neovim](https://img.shields.io/badge/Neovim-0.10.0+-green.svg)](https://neovim.io)

## ✨ Modern Tech Stack (June 2026)
- **Plugin Management:** Powered by [rocks.nvim](https://github.com/nvim-neorocks/rocks.nvim) for a robust, luarocks-based ecosystem.
- **Completion:** [blink.cmp](https://github.com/saghen/blink.cmp) for blazing-fast, Rust-powered completion.
- **UI & UX:** [snacks.nvim](https://github.com/folke/snacks.nvim) consolidates dashboard, notifications, and indentation lines into one high-performance plugin.
- **LSP:** Modernized with `lazydev.nvim` and optimized server configurations.
- **Language Support:** Strong focus on Python (`pylsp`), Lua, and professional development.
- **RTL Support:** Native-feeling Persian and Arabic support with dedicated optimizations.

## 🇮🇷 Persian (RTL) Support
NvPak is designed with RTL languages in mind.
- **Toggle RTL:** Use `<leader>rtl` to switch between LTR and RTL modes.
- **Terminal Optimization:** Toggle `termbidi` with `<leader>bd` for better RTL display in compatible terminals (like Konsole/Plasma).
- **Font:** Recommended font is **Vazirmatn RD Nerd Font** for perfect Persian glyphs and icons.

## 🚀 Installation

### Unix-like (Linux / macOS)
```bash
curl -sSL https://raw.githubusercontent.com/EvolveBeyond/NvPak/main/install.sh | bash
```

### Windows (PowerShell)
```powershell
irm https://raw.githubusercontent.com/EvolveBeyond/NvPak/main/install.ps1 | iex
```

## 🛠 Requirements
- **Neovim 0.10.0** or higher.
- **Git**
- **Luajit** (usually comes with Neovim)

## ⌨️ Keybindings
- `<leader>w` : Save file
- `<leader>q` : Quit
- `<leader>rtl` : Toggle RTL (Persian) mode
- `<leader>f` : Toggle fold (native treesitter folding)
- `<C-h/j/k/l>` : Window navigation
- `gd` : Go to definition
- `gr` : List references
- `<leader>ca` : Code actions

## 📦 Rocks TUI
NvPak includes a built-in TUI for managing your rocks. Run `:RocksTUI` to explore, install, and update plugins interactively.

---
*NvPak - Because your editor should be as fast as your thoughts.*
