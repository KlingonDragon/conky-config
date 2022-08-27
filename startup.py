#!/usr/bin/python3
import subprocess, time
from os import system as cmd
xr1 = None
while True:
    time.sleep(5)
    xr2 = subprocess.check_output(["xrandr"]).decode("utf-8").count(" connected ")
    if xr2 != xr1:
        cmd('killall conky')
        cmd('conky -c ~/.conky/klingondragon.conf &')
        cmd('conky -c ~/.conky/spotify/spotify.conf &')
        cmd('conky -c ~/.conky/spotify/image.conf &')
        if xr2 > 1:
            cmd('conky -c ~/.conky/klingondragon_2.conf &')
            cmd('conky -c ~/.conky/spotify/spotify_2.conf &')
            cmd('conky -c ~/.conky/spotify/image_2.conf &')
    xr1 = xr2