#!/bin/bash

backgrounds_dir=$(cat ~/.veu-toolbox/.backgrounds-dir-location)
wallpapers_names=$(ls "$backgrounds_dir")

selection=$(echo -e "$wallpapers_names" | rofi -dmenu -theme ~/.config/rofi/simple.rasi)
wallpaper_path="$backgrounds_dir/$selection"

hyprctl hyprpaper reload ,"$wallpaper_path"
