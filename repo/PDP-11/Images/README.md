
## Disk Images

**rt11V.dsk** - RL02 image w/ RT11 Basic v01 (R BASIC and BASIC-RT as R GBASIC). [[Link](https://groups.google.com/g/pidp-11/c/h-Wigv9ljnE/m/H5z9-qO6AAAJ)]

.ini file for simh:
```sh
set cpu 11/35
set cpu 64k
set RL0 RL02
att rl0 rt11V.dsk
set dz disable
set vt crt=vr14
set vt scale=2
set vt alias=on
set vt enable
boot rl0
```
