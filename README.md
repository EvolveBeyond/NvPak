<p align="center">
  <img width="256" height="256" src="https://user-images.githubusercontent.com/27810360/190279839-f6685b5f-4c56-41b3-b1b5-a8768cc52fb6.gif">
</p>





# NvPak
NvPak Nvim Config.
The purpose of creating this config is not to create a ready-made neovim for new users, the goal is to create something that every normal user does for config.\
If you intend to configure neovim, you will spend a lot of time collecting plugins, all neovim configurations or distributions try to help you by creating a perfect configuration, but I do not intend to help you by creating this configuration.\
Rather, I will give you a background to increase your speed in making your own configuration.\
It has been tried that all the plugins are installed at their basic level.\
and only a valid configuration has been done for it (as much as needed), also it has been tried to use the simplest neovim plugins as much as possible (lua plugins), But this basic configuration may be enough for your use.


### Requirements

 In order to make the best use of this config, you must meet the following prerequisites.


* `NVIM v0.7` or later versions 
* `unzip`
* `curl`
* `fd`
* `npm`
* for clipboard `xclip` or `xsel` for xorg and `wl-clipboard` for wayland
* `git`
* `bash` or `dash` and for windows `PowerShell v5.1` or later
* just for windows `Scoop.sh`
* `Nerd fonts`


### Screenshots
<details>
<summary>
Show
</summary>
<br>

![full](https://user-images.githubusercontent.com/27810360/181913981-0df5be10-76a8-42b0-b65b-2038d9a7d215.png)

![autocompelet](https://user-images.githubusercontent.com/27810360/181952849-abc1570b-ebbc-4a01-8617-08ded70d7d0c.png)

![Default](https://user-images.githubusercontent.com/27810360/181910797-a4fa6080-b2a9-4f96-8402-468f149abf3b.png)

![NeoVide](https://user-images.githubusercontent.com/27810360/181910971-43f34b7f-116a-4981-a9d6-37db0c1526f1.png)

![CmdLine](https://user-images.githubusercontent.com/27810360/181955593-80e4480b-e158-4be7-abe0-0509072d1118.png)

![debug](https://user-images.githubusercontent.com/27810360/181913848-50e240fc-51ce-40a9-a50b-4044418c8030.png)

</details>


### install

unix :
```bash
git clone --depth 1 https://github.com/Pakrohk-DotFiles/NvPak.git ~/.config/nvim && nvim 
```

windows :
```powershell
scoop bucket add extras
scoop install lazygit

(git clone --depth 1 https://github.com/Pakrohk-DotFiles/NvPak.git  ~\AppData\Local\nvim\) -and (nvim)
```

### Do you intend to help the progress of the project?

Great projects are not created by just one person.\
So please, if you use this project, try to help its development.\
Even if you don't have enough knowledge, you can help me troubleshoot it, just go to the issues tab.\
Also, if you plan to help me in developing features and solving bugs, just go to Projects tab.
