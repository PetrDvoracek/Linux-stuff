https://app.codility.com/c/feedback/DAGTEK-X2W/
# Linux-stuff
some notes about Debian and other Linux stuff. [Debian](https://www.debian.org/social_contract) and [Arch](https://wiki.archlinux.org/index.php/Arch_Linux#Principles) philosophy. 

## Debian Virtual-box setup

First add yourself to the sudo group
```
su -
sudo adduser <username> sudo
exit
```

the change will take effect the next time the user logs in.

if you are not be able to resize the screen to the optimal size (`xrandr` gives you only few options). Click *Devices->Insert Guest Addition...* above the screen on running virtual machine and reboot the machine. Now you should have mounted */media/cdrom*, run `sudo sh /media/cdrom/VBoxLinuxAdditions.run`, restart the virtual machine and it should automatically get in shape with your display.

[set timezone](https://jlk.fjfi.cvut.cz/arch/manpages/man/timedatectl.1)
```
timedatectl list-timezone
timedatectl  set-timezone Europe/Prague
```
[check if UEFI enabled](https://itsfoss.com/check-uefi-or-bios/), The easiest way to find out if you are running UEFI or BIOS is to look for a folder /sys/firmware/efi. The folder will be missing if your system is using BIOS.
```
ls /sys/firmware/efi
```
[Create partitions](https://itsfoss.com/install-arch-linux/)
First type
```
fdisk -l
```
which should shows mounted disks. Disk */dev/sda* is the main disk and */dev/loop0* could be ignored. To create the partitions type
```
fdisk /dev/sda
```
>**NOTE:**  **n**   - new partition
>           **p**   - partition type primary
>           **1**   - partition number (optional)
>                   - first sector can be default (2048)
>           **10G** - choose size of partition

### Partitioning
The simple scheme is to create 2G for *SWAP* and rest for */*. If yo want to change distributions often create another partition for */home* (so after reinstalation you wont lose any data from home)


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

## Git setup and [ssh-agent](https://www.root.cz/man/1/ssh-agent/) 
The agent s used for authentication when logging in to other machines using [ssh](https://www.root.cz/man/1/ssh/). To automatize process of `git push origin master` [generate ssh keys](https://www.root.cz/man/1/ssh-agent/)
```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```
start the ssh-agent in the background
```
eval "$(ssh-agent -s)"
```
and add created ssh to the agent
```
ssh-add ~/.ssh/id_rsa
```
now [add the SSH key to your GitHub account](https://help.github.com/en/articles/adding-a-new-ssh-key-to-your-github-account) (Settings->SSH and GPG keys).

Then [add remote](https://help.github.com/en/articles/changing-a-remotes-url#switching-remote-urls-from-https-to-ssh) into repository (must be located in the repo.) and verify
```
git remote set-url origin https://github.com/USERNAME/REPOSITORY.git
git remote -v
```









