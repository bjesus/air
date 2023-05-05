sudo mount --bind ~/Books ~/debian/Books
sudo mount --bind /proc ~/debian/proc
sudo mount --bind /proc ~/debian/sys
sudo mount --bind /tmp/.X11-unix ~/debian/tmp/.X11-unix
DISPLAY=:0 xhost + local:
sudo chroot ~/debian /bin/bash -c "DISPLAY=:0 koreader"
