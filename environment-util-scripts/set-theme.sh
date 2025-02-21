#!/bin/bash

# we read the list with themes
themes=$(cat ../themes-list)

# in case it was lost we restore it from backup
if [ -z "$themes" ]; then
    themes=$(cat ../themes-list.backup)
    echo "$themes" > ../themes-list
fi

# We select theme option
selection=$(echo -e "$themes" | rofi -dmenu -theme ~/.config/rofi/custom/default.rasi)
#selection=$(echo -e "$themes" | rofi -dmenu)

# in case this theme was already selected we do nothing
if echo "$selection" | grep -q "\*"; then
    echo "OK"
    exit 0
fi
#ls -l | rofi -dmenu -theme ~/.config/rofi/themes/my_theme.rasi

# we delete "*"(mark symbol) from previous selection and add it to the new one
themes=$(echo "$themes" | sed "s/ \*//g" | sed "s/$selection/$selection \*/g")
echo "$themes" > ../themes-list

# we add the necessary links to use this theme for configuration
echo "$selection"
cd ..

rm ~/.config/waybar
ln -s "$(pwd)/configs/waybar/$selection" ~/.config/waybar
rm ~/.config/rofi/custom
ln -s "$(pwd)/configs/rofi/$selection" ~/.config/rofi/custom

cd environment-util-scripts

pkill waybar && hyprctl dispatch exec waybar
