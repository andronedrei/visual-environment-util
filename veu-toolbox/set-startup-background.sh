#!/bin/bash

backgrounds_dir=$(cat ~/.veu-toolbox/.backgrounds-dir-location)
wallpapers_names=$(ls "$backgrounds_dir")

selection=$(echo -e "$wallpapers_names" | rofi -dmenu -theme ~/.config/rofi/simple.rasi)
wallpaper_path="$backgrounds_dir/$selection"

hyprpaper_loc=$(cat .main-dir-location)
hyprlock_loc="$hyprpaper_loc/configs/hypr/hyprlock.conf"
hyprpaper_loc="$hyprpaper_loc/configs/hypr/hyprpaper.conf"

# modify hyprpaper config file accordingly
first_two_lines="preload = $wallpaper_path"$'\n'"wallpaper = ,$wallpaper_path"
others=$(tail -n +3 "$hyprpaper_loc")

echo "$first_two_lines" > ~/.config/hypr/hyprpaper.conf
echo "$others" >> ~/.config/hypr/hyprpaper.conf

#modify hyprlock config file accordingly
first_two_lines=$(head -2 "$hyprlock_loc")
others=$(tail -n +4 "$hyprlock_loc")

# we set the background for hyperlock too
echo "$first_two_lines" > ~/.config/hypr/hyprlock.conf
echo "    path = $wallpaper_path" >> ~/.config/hypr/hyprlock.conf 
echo "$others" >> ~/.config/hypr/hyprlock.conf