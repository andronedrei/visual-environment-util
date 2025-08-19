#!/bin/bash

# we read the list with themes
themes=$(cat ~/.veu-toolbox/themes-list)

# in case it was lost we restore it from backup
if [ -z "$themes" ]; then
  themes=$(cat ~/.veu-toolbox/.themes-list.backup)
  echo "$themes" > ~/.veu-toolbox/themes-list
fi

# We select theme option
if [ -f ~/.config/rofi/simple.rasi ]; then
  selection=$(echo -e "$themes" | rofi -dmenu -theme ~/.config/rofi/simple.rasi)
else
  selection=$(echo -e "$themes" | rofi -dmenu) # use default config if no simple config was made before
fi

# in case this theme was already selected we do nothing
if echo "$selection" | grep -q "\*"; then
  exit 0
fi

# we delete "*"(mark symbol) from previous selection and add it to the new one
themes=$(echo "$themes" | sed "s/ \*//g" | sed "s/$selection/$selection \*/g")
echo "$themes" > ~/.veu-toolbox/themes-list

base_dir=$(cat ~/.veu-toolbox/.main-dir-location)

# we add the necessary links to use this theme for configuration
rm ~/.config/waybar
ln -s "$base_dir/configs/waybar/$selection" ~/.config/waybar
rm ~/.config/rofi
ln -s "$base_dir/configs/rofi/$selection" ~/.config/rofi
rm ~/.config/dunst
ln -s "$base_dir/configs/dunst/$selection" ~/.config/dunst

pkill waybar && hyprctl dispatch exec waybar
pkill dunst && hyprctl dispatch exec dunst
