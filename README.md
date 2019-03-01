https://app.codility.com/c/feedback/DAGTEK-X2W/
# Linux-stuff
some notes about Debian

## Debian Virtual-box setup

First add yourself to the sudo group
```
su -
sudo adduser <username> sudo
exit
```

the change will take effect the next time the user logs in.

if you are not be able to resize the screen to the optimal size (`xrandr` gives you only few options). Click *Devices->Insert Guest Addition...* above the screen on running virtual machine and reboot the machine. Now you should have mounted */media/cdrom*, run `sudo sh /media/cdrom/VBoxLinuxAdditions.run`, restart the virtual machine and it should automatically get in shape with your display.

## [i3 vm](https://i3wm.org/)

install with
```
sudo apt-get install i3 suckless-tools
```
[suckless-tools](https://en.wikipedia.org/wiki/Suckless.org) adds **dmenu** and other useful tools. After reboot you should be able to log in using i3 environment, after first login agree with creating of the new config file which will be in ~/.i3/config.

keybinds can be added with `bindsym $Mod+<key> <command> <arguments>`. The most fundamental keybinds are 

| Keybind | Function |
| ------- | -------- |
| $Mod+d  | app launcher |
| $Mod+Enter | terminal |

where $Mod stands for super or Alt (depends on the setting).

The changes in config will take effect after `i3 restart`

## Vim

Install vim with extra stuff [1](https://stackoverflow.com/questions/11489428/how-to-make-vim-paste-from-and-copy-to-systems-clipboard) [vim-gtk](https://packages.debian.org/jessie/vim-gtk)
```
sudo apt-get install vim vim-gtk
```
open vim with `vim` and type `:echo has('clipboard')` which should return 1 (if not, vim-gtk install was not successful).






