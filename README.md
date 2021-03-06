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
## Arch install notes
[Great](https://medium.com/@sks147/minimal-arch-linux-uefi-installation-with-i3-gaps-cfc507cc8be1)
### [set timezone](https://jlk.fjfi.cvut.cz/arch/manpages/man/timedatectl.1)
```
timedatectl list-timezone
timedatectl  set-timezone Europe/Prague
```
### [check if UEFI enabled](https://itsfoss.com/check-uefi-or-bios/)
The easiest way to find out if you are running UEFI or BIOS is to look for a folder /sys/firmware/efi. The folder will be missing if your system is using BIOS.
```
ls /sys/firmware/efi
```
### [Create partitions](https://itsfoss.com/install-arch-linux/)
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

### Grub
```
systemctl enable dhcpcd
pacman -S grub os-prober
grub-install /deb/sda
grub-mkconfig -o /boot/grub/grub.cfg
```
### Xorg
> **!!!xorg-server-utils are now in xorg-apps!!!**
```
pacman -S xorg-server xorg-xinit virtualbox-guest-utlis xorg-apps xorg-twm xorg-xclock xterm
```
optional: `pacman -S xorg-twm xorg-xclock`
start xserver
```
startx
```

### Users
add user
```
useradd -m -g users -s /bin/bash pedro
```
> **NOTE**: **-m**    - add home
### pacman
On 64-bit system uncomment [multilib] in /etc/pacman.conf


[resolv.conf](https://forum.piratebox.cc/read.php?7,21012)
sudo pacman -Syu
:: Synchronizing package databases...
error: failed retrieving file 'core.db' from mirrors.kernel.org : Could not resolve host: mirrors.kernel.org 
.
.
.
error: failed to update aur (download library error)
error: failed to synchronize any databases
error: failed to init transaction (download library error)

```
sudo rm /etc/resolv.conf
sudo sh -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf '
```
### [Chroot](https://wiki.archlinux.org/index.php/Chroot)
A chroot is an operation that changes the apparent root directory for the current running process and their children. A program that is run in such a modified environment cannot access files and commands outside that environmental directory tree. This modified environment is called a chroot jail. 
```
arch-chroot /mnt
```
**could be used to set up ssh on raspberry image?**

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

To be able to install `Plugin` apps, install [Vundle](https://github.com/VundleVim/Vundle.vim)

If you have problem with fonts in [powerline](https://github.com/powerline/powerline), check [fontconfig](https://powerline.readthedocs.io/en/latest/installation/linux.html)

## Git setup and [ssh-agent](https://www.root.cz/man/1/ssh-agent/) 
The agent s used for authentication when logging in to other machines using [ssh](https://www.root.cz/man/1/ssh/). To automatize process of `git push origin master` [generate ssh keys](https://www.root.cz/man/1/ssh-agent/)
```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```
start the ssh-agent in the background
```
eval "$(ssh-agent -s)"
```
and create `~/.ssh/config` file with following
```
Host <host url (after @ to .com)>
  HostName <host url (after @ to .com)>
  User <before @>
  PreferredAuthentications publickey
  IdentityFile ~/.ssh/<your private key (id_rsa)
```
now [add the SSH key to your GitHub account](https://help.github.com/en/articles/adding-a-new-ssh-key-to-your-github-account) (Settings->SSH and GPG keys).

Then [add remote](https://help.github.com/en/articles/changing-a-remotes-url#switching-remote-urls-from-https-to-ssh) into repository (must be located in the repo.) and verify
```
git remote set-url origin https://github.com/USERNAME/REPOSITORY.git
git remote -v
```

## [Systemd](https://www.youtube.com/watch?v=o_AIw9bGogo)
### Service
superset of a daemon, often consist of multiple daemons
[Rethinking PID 1](http://0pointer.de/blog/projects/systemd.html)
"It's buggy!" -> "It's software"

# Web

[siege tool](https://linux.die.net/man/1/siege)

# VIM over ssh
```
:set t_Co=256
```

# [Python compiled from source code](https://realpython.com/installing-python/)
```
wget https://www.python.org/ftp/python/3.6.5/Python-3.6.5.tgz
sudo apt-get update
sudo apt-get upgrade
```
Make sure the system has the tools needed to build Python with 
```
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev  libncursesw5-dev xz-utils tk-dev
```
Build downloaded Python file, -j splits build process into parallel processes
```
tar xvf Python-3.6.5.tgz
cd Python-3.6.5
./configure --enable-optimizations --with-ensurepip=install
make -j 8
```
now install! **altinstall** will not override system's python
```
sudo make altinstall
```
# Python apt-get and specific version

```
sudo apt-get install software-properties-common #for newest debian/ubuntu
sudo apt-get install python-software-properties # for debian < 8 ubuntu < 14
```
this will add add-apt-repository functionality to debian
```
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update
sudo apt-get install python3.7
```

## Python for Linux Mint

[source](https://linuxize.com/post/how-to-install-python-3-7-on-ubuntu-18-04/)

```
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install python3.7
```







