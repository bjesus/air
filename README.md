# Awesome Interface for e-Readers

![AIR screenshot](https://user-images.githubusercontent.com/55081/172224765-9f0efab0-f555-45b5-a053-186d2300373a.png)

AIR is an graphical interface for e-readers that heavily relies on AwesomeWM. It's tested on the Kobo Clara HD using PostmarketOS, but perhaps it can be used elsewhere. It is a work in progress.

## Features
- Tilling interface
- Brightness control
- WiFi toggling
- Suspend / Resume
- Touch gestures
- On screen keyboard

You can use any Linux application with it, for example:
- KOReader or Foliate for ebooks
- Firefox for (slow) web
- Castor for Gopher and Gemini
- St for terminal

## Setup

AIR isn't nicely packed as it's actually just a collection of different tools, together with an AwesomeWM configuration. Setting up takes a couple of steps:

0. `cd ~/.config && git clone https://github.com/bjesus/air.git awesome`

1. Install all needed packages: `sudo apk add awesome util-linux-misc svkbd lisgd network-manager-applet pm-utils brightnessctl upower adwaita-icon-theme font-inter xrandr`

2. If you want, install the additional optional software: `sudo apk add foliate castor mobile-config-firefox sxmo-st`

3. Place your background image at `~/.config/awesome/bg.jpg`

4. Set your default desktop environment: `sudo tinydm-set-session -f -s /usr/share/xsessions/awesome.desktop`

5. Allow password-less rfkill, suspend and poweroff by adding this to `/etc/sudoers`:
```
YOUR_USERNAME ALL=NOPASSWD: /usr/sbin/rfkill
YOUR_USERNAME ALL=NOPASSWD: /usr/sbin/pm-suspend
YOUR_USERNAME ALL=NOPASSWD: /sbin/poweroff
YOUR_USERNAME ALL=NOPASSWD: /usr/sbin/chroot
YOUR_USERNAME ALL=NOPASSWD: /bin/mount
YOUR_USERNAME ALL=NOPASSWD: /usr/bin/tee
```

6. Set some font-size optimizations by copying `~/.config/awesome/.Xresources` to `~/.Xresources` and `~/.config/awesome/settings.ini` to `~/.config/gtk-3.0/settings.ini`

7. `chmod +x ~/.config/awesome/suspend.sh`

8. Rotate the touchscreen by create /etc/X11/xorg.conf.d/rotate.conf with this:
```
Section "InputClass"
            Identifier "Coordinate Transformation Matrix"
            MatchIsTouchscreen "on"
            MatchDevicePath "/dev/input/event*"
            MatchDriver "libinput"
            Option "CalibrationMatrix" "0 -1 1 1 0 0 0 0 1"
EndSection
```

### KOReader

The only way I managed to run KOReader is using a Debian chroot. Get the Debian package from [KOReader releases page](https://github.com/koreader/koreader/releases). Creating the chroot is pretty simple:

```
sudo apk add debootstrap xhost
$ sudo debootstrap  testing ~/debian http://http.debian.net/debian/
$ cp koreader-2023.04-armhf.deb ~/chroot/root 
$ mkdir -p ~/chroot/tmp/.X11-unix
$ sudo chroot ~/chroot /bin/bash

# inside the chroot:
$ apt update && apt install libsdl2-2.0-0 fonts-noto-hinted fonts-droid-fallback 
$ sudo dpkg -i /root/koreader-2023.03-armhf.deb
```

You should now be able to use the koreader.sh script to launch KOReader.

## Usage

The menu on the bottom left is where you can launch your applications. By default it uses Foliate, Firefox, Castor and St. The bottom right has a gears icon that opens the Settings modal. You can set brightness using it, toggle the WIFI and restart. The keyboard icon toggles the keyboard.

### Gestures

AIR uses lisgd for gestures. By default the following gestures are set:
- Sliding up from the bottom edge toggles the keyboard
- Sliding down from the top left opens the settings modal
- Sliding down from the top right shows window controls for the currently focused window (useful for killing an app)

## Known issues
- Battery status reporting is off
- GTK header buttons are tiny. Can be fixed by setting `GDK_SCALE` but for me it crashes Foliate.

