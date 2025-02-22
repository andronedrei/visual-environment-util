#!/bin/bash

backgrounds_dir=$(cat .backgrounds-dir-location)
wallpapers_names=$(ls "$backgrounds_dir")

selection=$(echo -e "$wallpapers_names" | rofi -dmenu -theme ~/.config/rofi/simple.rasi)
wallpaper_path="$backgrounds_dir/$selection"

hyprpaper_loc=$(cat .main-dir-location)
hyprpaper_loc="$hyprpaper_loc/configs/hypr/hyprpaper.conf"

first_two_lines="preload = $wallpaper_path"$'\n'"wallpaper = ,$wallpaper_path"
others=$(tail -n +3 "$hyprpaper_loc")

echo "$first_two_lines" > ~/.config/hypr/hyprpaper.conf
echo "$others" >> ~/.config/hypr/hyprpaper.conf
