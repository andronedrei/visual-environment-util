#!/bin/bash

base_dir=$(cat ~/.veu-toolbox/.main-dir-location)

# we read the list with prompts
prompts=$(ls "$base_dir/configs/starship")

# We select theme option
if [ -f ~/.config/rofi/simple.rasi ]; then
  selection=$(echo -e "$prompts" | rofi -dmenu -theme ~/.config/rofi/simple.rasi)
else
  selection=$(echo -e "$prompts" | rofi -dmenu) # use default config if no simple config was made before
fi

# we add the necessary links to use this theme for configuration
rm ~/.config/starship
ln -s "$base_dir/configs/starship/$selection" ~/.config/starship
