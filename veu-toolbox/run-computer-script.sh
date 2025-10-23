#!/bin/bash

# script used by different waybars setups (and not only) for easy acces to other relevant scripts

scripts=$(cat ~/.veu-toolbox/computer-scripts-list.txt)

# in case file with scripts was lost we restore it from backup
if [ -z "$scripts" ]; then
    scripts=$(cat ~/.veu-toolbox/.computer-scripts-list.backup)
    echo "$scripts" > ~/.veu-toolbox/computer-scripts-list.txt
fi

scripts_names=$(echo "$scripts" | xargs -n 1 basename)

# we select a script option
selected=$(echo -e "$scripts_names" | rofi -dmenu -p "Select a script" -theme ~/.config/rofi/simple.rasi)

# if a valid script is selected
if [ -n "$selected" ]; then
    # prompt for potential arguments
    arguments=$(rofi -dmenu -p "Enter additional arguments for \"$selected\": " -theme ~/.config/rofi/prompt.rasi)
  
    # we reconstruct the full path
    script=$(echo "$scripts" | grep "$selected")

    # we change our location to the script's one (and save current location)
    original_dir=$(pwd)
    script_dir=$(echo "$script" | sed "s#\/$selected##g")
    cd "$script_dir"
    
    # we run the script (with arguments if present)
    "$script" $arguments
    cd "$original_dir"
fi
