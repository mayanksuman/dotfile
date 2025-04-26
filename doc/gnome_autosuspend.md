1. First turn off auto-suspend in Gnome user setting. However, GDM uses different setting as nouser is logged in.
To only disable auto-suspend on AC in GDM, run:

$ sudo -Hu gdm dbus-launch gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'

On Debian the gdm user can be Debian-gdm. If 'dbus-launch' command is not found then install 'dbus-x11' package. (To also disable auto-suspend on battery, run the command with battery instead of ac.)

    OR

2. Disable Suspend Globally (Root Privileges Required):

    Open a terminal and use 'sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target' to disable suspend and hibernation. 

To re-enable, use sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target. 
Note: This will prevent suspend and hibernation entirely. 

OR

2. Consider Systemd Logind Configuration:

    You can modify /etc/systemd/logind.conf to login automatically.

Note: This requires root privileges and careful editing of the file. 

