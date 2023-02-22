<p align="center">
  <img width="256" height="256" src="https://user-images.githubusercontent.com/27810360/190279839-f6685b5f-4c56-41b3-b1b5-a8768cc52fb6.gif">
</p>

<div align="center">

[![APACHEv3 license](https://img.shields.io/badge/License-APACHEv2-red.svg?style=flat-square)](https://github.com/Pakrohk-DotFiles/NvPak/blob/main/LICENSE)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg?style=flat-square)](https://github.com/Pakrohk-DotFiles/NvPak/graphs/commit-activity)
[![Neovim Minimum Version](https://img.shields.io/badge/Neovim-0.8.0-blueviolet.svg?style=flat-square&logo=Neovim&color=90E59A&logoColor=white)](https://github.com/neovim/neovim)
[![Maintainer](https://img.shields.io/badge/maintainer-theMaintainer-blue?style=flat-square)](https://github.com/Pakrohk)
[![GitHub Issues](https://img.shields.io/github/issues/pakrohk-dotfiles/NvPak.svg?style=flat-square&label=Issues&color=d77982)](https://github.com/Pakrohk-DotFiles/NvPak/issues)

# NvPak

NvPak is a mandatory requirement to end generating complex configs for neovim.\
PaK in Farsi means pure(clear), something that is available in its simplest form in its purest form.\
but don't get me wrong, this is not a Neovim distribution, this config is designed for you to fork it.\
However, it may be enough for you without the need to change.

</div>

## Requirements

In order to make the best use of this config, you must meet the following prerequisites.

- `NVIM v0.8.0` or later versions
- `unzip`
- `curl`
- `node.js` and `npm` or `pnpm` or `yarn`
- `ripgrep` or `fd` for [Fuzzy Finder Telescope](https://github.com/BurntSushi/ripgrep)
- for clipboard `xclip` or `xsel` for xorg and `wl-clipboard` for wayland
- `git`
- If you are a Python developer, `pynvim`
- `bash` or `dash` and for windows `PowerShell v5.1` or later
- Just for windows `Scoop.sh`
- install [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts)

### Screenshots

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

### Installation

Unix :

```bash
git clone --depth 1 https://github.com/Pakrohk-DotFiles/NvPak.git ~/.config/nvim && nvim
```

Windows :

```powershell
scoop bucket add extras
scoop install lazygit
(git clone --depth 1 https://github.com/Pakrohk-DotFiles/NvPak.git  ~\AppData\Local\nvim\) -and (nvim)
```

### Usage

If the software plugins are not installed automatically after the first run!
Proceed as follows.

Run

```lua
:PackerSync
```

Also, if tabnine doesn't show you any offers, just log in to your account.

Run

```lua
:CmpTabnineHub
```

inside nvim to install the packages.\
Then restart nvim and enjoy.

### Do you intend to help the progress of the project?

Great projects are not created by just one person.\
So please, if you use this project, try to help its development.\
Even if you don't have enough knowledge, you can help me troubleshoot it,
just go to the issues tab.\
Also, if you plan to help me in developing features and solving bugs,
just go to Projects tab.
