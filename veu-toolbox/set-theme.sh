#!/bin/bash

base_dir=$(cat ~/.veu-toolbox/.main-dir-location)

# we read the list with themes
themes=$(ls "$base_dir/configs/waybar")

# We select theme option
if [ -f ~/.config/rofi/simple.rasi ]; then
  selection=$(echo -e "$themes" | rofi -dmenu -theme ~/.config/rofi/simple.rasi)
else
  selection=$(echo -e "$themes" | rofi -dmenu) # use default config if no simple config was made before
fi

# we add the necessary links to use this theme for configuration
rm ~/.config/waybar
ln -s "$base_dir/configs/waybar/$selection" ~/.config/waybar
rm ~/.config/rofi
ln -s "$base_dir/configs/rofi/$selection" ~/.config/rofi
rm ~/.config/dunst
ln -s "$base_dir/configs/dunst/$selection" ~/.config/dunst

pkill waybar && hyprctl dispatch exec waybar
pkill dunst && hyprctl dispatch exec dunst
