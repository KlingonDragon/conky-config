#!/usr/bin/python3
import subprocess
import time

def get(cmd): return subprocess.check_output(cmd).decode("utf-8")
def run_command(cmd): subprocess.Popen(["/bin/bash", "-c", cmd])

xr1 = None
while True:
    time.sleep(5)
    xr2 = get(["xrandr"]).count(" connected ")
    if xr2 != xr1:
        run_command('killall conky')
        run_command('conky -c ~/.conky/klingondragon.conf')
        run_command('conky -c ~/.conky/spotify/spotify.conf')
        run_command('conky -c ~/.conky/spotify/image.conf')
        if xr2 >1:
            run_command('conky -c ~/.conky/klingondragon_2.conf')
            run_command('conky -c ~/.conky/spotify/spotify_2.conf')
            run_command('conky -c ~/.conky/spotify/image_2.conf')
    xr1 = xr2