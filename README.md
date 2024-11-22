<p align="center">
  <img width="256" height="256" src="https://user-images.githubusercontent.com/27810360/190279839-f6685b5f-4c56-41b3-b1b5-a8768cc52fb6.gif">
</p>

<div align="center">

[![APACHEv3 license](https://img.shields.io/badge/License-APACHEv2-red.svg?style=flat-square)](https://github.com/Pakrohk-DotFiles/NvPak/blob/main/LICENSE)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg?style=flat-square)](https://github.com/Pakrohk-DotFiles/NvPak/graphs/commit-activity)
[![Neovim Minimum Version](https://img.shields.io/badge/Neovim-0.8.0-blueviolet.svg?style=flat-square&logo=Neovim&color=90E59A&logoColor=white)](https://github.com/neovim/neovim)
[![Maintainer](https://img.shields.io/badge/maintainer-theMaintainer-blue?style=flat-square)](https://github.com/Pakrohk)
[![GitHub Issues](https://img.shields.io/github/issues/pakrohk-dotfiles/NvPak.svg?style=flat-square&label=Issues&color=d77982)](https://github.com/Pakrohk-DotFiles/NvPak/issues)

</div>

---

# NvPak: Clean and Simple Defaults for Neovim 🚀

NvPak simplifies configuring Neovim by providing a clean starting point with sensible defaults. Instead of reinventing the wheel, you can fork NvPak and customize it based on your unique needs—focusing on what matters most.

Please note:

- **NvPak is not a pre-configured Neovim setup.** It’s designed to help you build your configuration from the ground up.  
- **NvPak does not compete with projects like NvChad or LazyVim.** It’s for users who want minimal interference and full control over their Neovim experience.

---

## Why the Name "NvPak"? 🌐

- **"Nv"**: Short for **Neovim**.  
- **"Pak"**: Derived from the Persian word **"پاک"**, meaning **clean**. This represents clarity, simplicity, and organization—qualities NvPak embodies.

---

## Requirements 📦

Before using NvPak, ensure the following dependencies are installed:

### Core Requirements 🛠️

- **Neovim**: Version `0.8.0` or newer.
- **Unzip**
- **Curl**
- **Ripgrep** or **fd**: Required for [Telescope](https://github.com/BurntSushi/ripgrep) fuzzy finder.
- **Git**
- **Nerd Fonts**: Install [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) for proper icon rendering.

### Clipboard Support ✂️

- **For Xorg**: Install `xclip` or `xsel`.
- **For Wayland**: Install `wl-clipboard`.

### For Python Developers 🐍

- Install `pynvim`.

### For Windows Users 🪟

- **PowerShell**: Version `v5.1` or later.
- **Scoop.sh**: For dependency management.
- Install `lazygit` via Scoop:  

  ```powershell
  scoop install lazygit
  ```

---

## Installation ⚙️

### Unix 🐧

Run the following command in your terminal:

```bash
git clone --depth 1 https://github.com/Pakrohk-DotFiles/NvPak.git ~/.config/nvim && nvim
```

### Windows 🪟

Execute this in PowerShell:

```powershell
bucket add extras
scoop install lazygit
(git clone --depth 1 https://github.com/Pakrohk-DotFiles/NvPak.git ~\AppData\Local\nvim\) -and (nvim)
```

### Notes 📝

- 💡 Ensure `git` is installed before proceeding.
- 💡 On Unix, the `nvim` command should be available. Install Neovim via your system's package manager if necessary.
- 💡 On Windows, install `scoop` and `lazygit` before running the setup commands.

---

## Screenshots 📷

<details>
<summary>Click to view</summary>
<br>

![Full](https://user-images.githubusercontent.com/27810360/215935940-81f0b59b-9382-4915-a395-f6903f07c1a8.png)  
*Full Interface Example*

![Autocompletion](https://user-images.githubusercontent.com/27810360/215936237-96bc8604-1597-4aa9-bbfb-4709cae73016.png)  
*Autocompletion*

![NeoVide](https://user-images.githubusercontent.com/27810360/181910971-43f34b7f-116a-4981-a9d6-37db0c1526f1.png)  
*NeoVide Integration*

![Fuzzy Finder](https://user-images.githubusercontent.com/48873115/217238383-51c83389-ef78-414c-bdda-2896033ce389.png)  
*Telescope Fuzzy Finder*

![Command Line](https://user-images.githubusercontent.com/27810360/181955593-80e4480b-e158-4be7-abe0-0509072d1118.png)  
*Enhanced Command Line*

![Errors and Warnings](https://user-images.githubusercontent.com/27810360/215936761-4ec5c34c-789e-426f-91a4-dca3b6b2a7d1.png)  
*Error and Warning Details*

</details>

---

## Usage 🚀

If plugins are not installed automatically during the first launch, you can manually install them:

1. Open Neovim.
2. Run the following command:

   ```
   :Lazy sync
   ```

3. Restart Neovim.
4. Enjoy your customized environment!

---

## Contributing 🤝

We welcome contributions from the community! Whether you're fixing bugs, adding features, or suggesting improvements, here's how you can get involved:

1. **Find an Issue or Suggestion**:
   - Check the [Projects](https://github.com/EvolveBeyond/NvPak/projects) section for tasks to work on.
   - If you have a new idea, discuss it with the [NvPak](https://github.com/EvolveBeyond/NvPak) team.

2. **Fork the Repository**:
   - Create your fork and clone it locally.

3. **Make Your Changes**:
   - Follow the project's coding standards.
   - Write clear and descriptive commit messages.

4. **Submit a Pull Request**:
   - Open a PR from your fork to the main NvPak repository.
   - Your changes will be reviewed and merged upon approval.

By contributing, you help make NvPak better for everyone and collaborate with like-minded developers.

### Contributors 🌟

<a href="https://github.com/EvolveBeyond/nvpak/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=EvolveBeyond/nvpak" />
</a>

---

## License 📜

NvPak is licensed under the [Apache v2.0 License](https://github.com/Pakrohk-DotFiles/NvPak/blob/main/LICENSE). Feel free to use and modify it according to the license terms.
