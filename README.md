# Conky configuration files

## Features
### [`klingondragon.conf`](klingondragon.conf)
- Time
  - Day
  - Week Number
  - ISO Date/Time
  - Epoch
- System
  - Uptime
  - CPU (4 cores)
  - RAM
  - Swap
- Disk
  - Disk Usage
    - `/`
    - `/home`
  - Disk I/O
- Network
  - Public IP
  - Local IP
  - Upload Speed
  - Download Speed
- Weather (From [chubin/wttr.in](https://github.com/chubin/wttr.in))
 - Condition
 - Temp
 - Sunrise/Sunset Times
### [`spotify/spotify.conf`](spotify/spotify.conf) (Inspired by [mcinquin/conky-spotify](https://github.com/mcinquin/conky-spotify))
- Current Track
- Artist
- Album
- Progress Bar and Times
- Shuffle and Repeat notification

### [`spotify/image.conf`](spotify/image.conf)
 - Album Art for Current Track


## Use them yourself?
I start conky by running [`conky.sh`](conky.sh).
### Configuration
- [`spotify/spotify_getinfo.pl`](spotify/spotify_getinfo.pl) (Line 26)
  > Update your home path
```perl
my $home_directory = "/home/klingondragon";
```
- [`klingondragon.conf`](klingondragon.conf) (Lines 46 and 48)
  > Check your disks/partitions and change the paths
```
${font :pixelsize=16}${fs_type /}  /  $alignr  ${fs_used /}/${fs_size /} (${fs_used_perc /}%)
...
${fs_type /home}  /home  $alignr  ${fs_used /home}/${fs_size /home} (${fs_used_perc /home}%)
```
- [`klingondragon.conf`](klingondragon.conf) (Lines 58-61)
  > Check your interfaces and change the ids (I used `netstat -i` in the terminal)
```
${font}LAN  $alignr  ${addrs enp4s0}${font :pixelsize=10} (enp4s0)
$alignr↑ ${upspeed enp4s0} ${upspeedgraph enp4s0 8,80}    ↓ ${downspeed enp4s0} ${downspeedgraph enp4s0 8,80}$font
${wireless_essid wlp3s0}  $alignr  ${addrs wlp3s0}${font :pixelsize=10} (wlp3s0)
$alignr↑ ${upspeed wlp3s0} ${upspeedgraph wlp3s0 8,80}    ↓ ${downspeed wlp3s0} ${downspeedgraph wlp3s0 8,80}${font :pixelsize=2}
Configuration assumes all these files are in the `~/.conky` directory (e.g. `conky.sh` is at `~/.conky/conky.sh`)
```
- [`weather.sh`](weather.sh) (Line 2)
  > Choose your Location
```sh
LOCATION="London"
```
If these files are stored elsewhere, you will need to make more changes to the configuration files.
## Multiple monitors
[`startup.py`](startup.py) starts conky 3 or 6 times.
All 3 configuration files have copies that set the monitor to 2 and window type to panel. `startup.py` runs these second files if it finds multiple monitors else it just runs the normal ones

Feel free to remove these if you only have one monitor or only want it on one. If you only want it on one monitor but want to change which monitor is used you can add `xinerama_head = ?` to the config options of each `.conf` file replacing `?` with the number of the monitor you wish to use