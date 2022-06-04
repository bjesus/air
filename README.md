# Awesome Interface for e-Readers

![AIR screenshot](https://host.yoavmoshe.com/store/kobo.jpg)

AIR is an graphical interface for e-readers that heavily relies on AwesomeWM. It's tested on the Kobo Clara HD using PostmarketOS, but perhaps it can be used elsewhere. It is a work in progress.

## Features
- Tilling interface
- Brightness control
- WiFi toggling
- Suspend / Resume
- Touch gestures
- On screen keyboard

You can use any Linux application with it, for example:
- Foliate for ebooks
- Firefox for (slow) web
- Castor for Gopher and Gemini
- St for terminal

## Setup

AIR isn't nicely packed as it's actually just a collection of different tools, together with an AwesomeWM configuration. Setting up takes a couple of steps:

0. `cd ~/.config && git clone https://github.com/bjesus/air.git awesome`

1. Install all needed packages: `sudo apk add awesome util-linux-misc svkbd lisgd network-manager-applet pm-utils brightnessctl upower gnome-icon-theme font-inter`

2. If you want, install the additional optional software: `sudo apk add foliate castor mobile-config-firefox sxmo-st`

3. Place your background image at `~/.config/awesome/bg.jpg`

4. Set your default desktop environment: `sudo tinydm-set-session -f -s /usr/share/xsessions/awesome.desktop`

5. Allow password-less rfkill, suspend and poweroff by adding this to `/etc/sudoers`:
```
YOUR_USERNAME ALL=NOPASSWD: /usr/sbin/rfkill
YOUR_USERNAME ALL=NOPASSWD: /usr/sbin/pm-suspend
YOUR_USERNAME ALL=NOPASSWD: /sbin/poweroff
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

## Usage

The menu on the bottom left is where you can launch your applications. By default it uses Foliate, Firefox, Castor and St. The bottom right has a gears icon that opens the Settings modal. You can set brightness using it, toggle the WIFI and restart. The keyboard icon toggles the keyboard.

### Gestures

AIR uses lisgd for gestures. By default the following gestures are set:
- Sliding up from the bottom edge toggles the keyboard
- Sliding down from the top left opens the settings modal
- Sliding down from the top right shows window controls for the currently focused window (useful for killing an app)

## Known issues

- Rotation is buggy - generally the moment the screen is rotated, it freezes. AIR runs `watch -n 0.5 xset dpms force on` to force a screen refresh every 0.5 seconds.
- Battery status reporting is off
- GTK header buttons are tiny. Can be fixed by setting `GDK_SCALE` but for me it crashes Foliate.
- Suspend doesn't work on first attempt
