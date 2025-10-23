#!/bin/bash

options="set-theme
set-current-background
set-startup-background
set-prompt"

selection=$(echo -e "$options" | rofi -dmenu -p "Power options" -theme ~/.config/rofi/simple.rasi)

case "$selection" in
    "set-theme")
        ~/.veu-toolbox/set-theme.sh ;;
    "set-current-background")
        ~/.veu-toolbox/set-current-background.sh ;;
    "set-startup-background")
        ~/.veu-toolbox/set-startup-background.sh ;;
    "set-prompt")
        ~/.veu-toolbox/set-prompt.sh ;;
    *)
        echo "Nothing" ;;
esac