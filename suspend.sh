#!/bin/sh

FILE=/tmp/sleeping
if [ -f "$FILE" ]; then
	rm $FILE
        notify-send "Welcome back" "Waking up..." -t 1000
else
	touch $FILE
	brightnessctl -d "backlight_warm" s 0
	brightnessctl -d "backlight_cold" s 0
	sudo rfkill block 0
	notify-send "Sleeping" "zzz" -t 2000
	sleep 1
	sudo pm-suspend
fi

