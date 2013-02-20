#!/bin/sh
~/bin/video_setup.sh
#nitrogen --restore &
feh --bg-fill /home/pawel/Pictures/Wallpapers/apple/nwy2T.jpg &
dunst &
(nm-applet || wicd-gtk -t) &
parcellite &
ubuntuone-launch &
xscreensaver -no-capture-stderr -no-splash &
thunar --daemon &
