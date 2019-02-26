# Linux-stuff
some notes about Debian

## Debian Virtual-box setup

After successfull installation, maybe you will not be able to resize the screen to the optimal size (`xrandr` gives you only few options). Click *Devices->Insert Guest Addition...* above the screen on running virtual machine and reboot the machine. Now you should have mounted */media/cdrom*, run `sudo sh /media/cdrom/VBoxLinuxAdditions.run`, restart the virtual machine and it should automatically get in shape with your display.

