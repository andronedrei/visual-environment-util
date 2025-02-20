#!/bin/bash

options="🔴\n🔁\n⏸️"

selection=$(echo -e "$options" | rofi -dmenu)

case "$selection" in
    "🔴")
        systemctl poweroff ;;
    "🔁")
        reboot ;;
    "⏸️")
        systemctl suspend ;;
    *)
        echo "Nothing" ;;
esac