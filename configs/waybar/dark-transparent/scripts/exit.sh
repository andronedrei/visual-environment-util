#!/bin/bash

options="🔴 Poweroff\n🔁 Restart\n⏸️ Suspend"

selection=$(echo -e "$options" | rofi -dmenu -p "Power options" -theme ~/.config/rofi/compact.rasi)

case "$selection" in
    "🔴 Poweroff")
        systemctl poweroff ;;
    "🔁 Restart")
        reboot ;;
    "⏸️ Suspend")
        systemctl suspend ;;
    *)
        echo "Nothing" ;;
esac