# Changelog

All notable changes to NvPak will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Fixed
- B1: `EditTheme` command now requires `plugins.theme.config`, fixing `nil` table error.
- B2: Repo URLs updated from `Pakrohk-DotFiles` to `EvolveBeyond` across install/update scripts and README badges.
- B3: Added missing `mason.nvim` core plugin declaration to `rocks.toml`.
- B4: Added missing `mini.nvim` plugin declaration (provides `mini.comment` used by `<leader>gc`/`gcc` bindings).
- B5: Added 4 orphaned theme modules (dracula, monokia, nord, rose-pine) to `rocks.toml` so they are installable.
- M1: Removed deprecated `use_nvim_cmp_as_default` key from blink.cmp config.
- M2: Removed stale `lfs` global from `.luarc.json` (unused dependency).
- M3: Replaced deprecated `mason-lspconfig` v1 API (`ensure_installed`, `automatic_installation`, `setup_handlers`) with direct `lspconfig` server setup leveraging `lazydev.nvim`.
- M4: Updated RTL toggle to use `vim.opt.rightleft` instead of deprecated `vim.opt.rl`.

### Added
- M5: Added `CHANGELOG.md`.
- Added `lua/plugins/ui/mini.lua` config module for `mini.nvim` plugins (currently `mini.comment`).

## [2026-Zen] - Modernization Release
- Migrated to `blink.cmp` completion engine.
- Integrated `snacks.nvim` for dashboard, notifications, and indentation.
- Added native Treesitter folding (Neovim 0.10+).
- Added built-in Persian/Arabic RTL support via `<leader>rtl`.
- Added `rocks.nvim` package management via `rocks.toml`.
