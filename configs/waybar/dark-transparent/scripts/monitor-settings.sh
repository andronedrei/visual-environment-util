#!/bin/bash

options="brightness
contrast"

set_brightness() {
    # prepare selection menu
    local options=$(seq 0 5 100)
    local cur_value=$(ddcutil getvcp 0x10 | sed 's/0x[0-9]*//g' | sed 's/[^[0-9,]//g' | sed 's#,#\n#g' | head -1)
    
    # set the new choosen brightness
    local selection=$(echo -e "$options" | rofi -dmenu -p "Current brightness $cur_value" -theme ~/.config/rofi/simple.rasi)
    ddcutil setvcp 0x10 "$selection"
}

set_contrast() {
    # prepare selection menu
    local options=$(seq 0 5 100)
    local cur_value=$(ddcutil getvcp 0x12 | sed 's/0x[0-9]*//g' | sed 's/[^[0-9,]//g' | sed 's#,#\n#g' | head -1)
    
    # set the new choosen contrast
    local selection=$(echo -e "$options" | rofi -dmenu -p "Current brightness $cur_value" -theme ~/.config/rofi/simple.rasi)
    ddcutil setvcp 0x12 "$selection"
}

selection=$(echo -e "$options" | rofi -dmenu -p -theme ~/.config/rofi/compact.rasi)

case "$selection" in
    "brightness")
        set_brightness ;;
    "contrast")
        set_contrast ;;
    *)
        echo "Invalid option" ;;
esac