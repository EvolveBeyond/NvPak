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

In order to make the best use of this config, you must meet the following prerequisites.

- `neovim v0.8.0` and later versions or `neovide v0.10.3` and later Version
- `unzip`
- `curl`
- `ripgrep` or `fd` for [Fuzzy Finder Telescope](https://github.com/BurntSushi/ripgrep)
- For clipboard support:
  - `xclip` or `xsel` for Xorg
  - `wl-clipboard` for Wayland
- `git`
- If you are a Python developer, `pynvim`
- `bash` or `dash` for Unix-based systems
- `PowerShell v5.1` or later for Windows
- Only for Windows: `Scoop.sh`
- Install [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) for better icon support.

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
## Unix 🐧
bash
```bash
git clone --depth 1 https://github.com/Pakrohk-DotFiles/NvPak.git ~/.config/nvim && nvim
```
## Windows 🪟
powershell
```powershell
bucket add extras
scoop install lazygit
(git clone --depth 1 https://github.com/Pakrohk-DotFiles/NvPak.git ~\AppData\Local\nvim\) -and (nvim)
```
### Notes:

You need to have git installed first.
On Unix,nvim command-line executable should be installed. \
If it is not installed, you can install it using your system's **package manager**.\
On Windows, you need to have scoop installed first. \
Then, install lazygit by running scoop install lazygit.\
Afterwards, run the remaining commands sequentially.

The --depth 1 option of the git clone command fetches only the latest changes from the repository and does not retrieve the entire history.\
This reduces the download time.\
The \ character in Windows is used to continue a command on a new line.


# Usage: 🚀

If the software plugins are not installed automatically after the first run, follow these steps:

Run the following command inside nvim:

```
:Lazy sync
```

Restart nvim.

Enjoy!





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

| ![pakrohk](https://github.com/Pakrohk.png?size=71) | ![ARS101](https://github.com/ARS101.png?size=71) | ![lorem10](https://github.com/lorem10.png?size=71) | ![nooob-developer](https://github.com/nooob-developer.png?size=71) |
| :------------------------------------------------: | :----------------------------------------------: | ------------------------------------- | -------------- |
| [Pakrohk](https://github.com/Pakrohk) | [ARS101](https://github.com/ARS101) | [lorem10](https://github.com/lorem10) | [nooob-developer](https://github.com/nooob-developer) |

| [H-cyber](https://github.com/H-cyber.png?size=74) | ![mandarvaze](https://github.com/mandarvaze.png?size=74) | ![RealMrHex](https://github.com/RealMrHex.png?size=74) | ![0xj0hn](https://github.com/0xj0hn.png?size=74) |
| --------------------------------------- | ------------------------------------------------------ | --------------------- | ----------------------- |
| [H-cyber](https://github.com/H-cyber) | [mandarvaze](https://github.com/mandarvaze) | [RealMrHex](https://github.com/RealMrHex) | [0xj0hn](https://github.com/0xj0hn) |

