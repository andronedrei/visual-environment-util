#!/bin/bash

# we read the list with prompts
prompts=$(cat ~/.veu-toolbox/.prompts-list)

# in case it was lost we restore it from backup
if [ -z "$prompts" ]; then
  prompts=$(cat ~/.veu-toolbox/.prompts-list.backup)
  echo "$prompts" > ~/.veu-toolbox/prompts-list
fi

# We select theme option
if [ -f ~/.config/rofi/simple.rasi ]; then
  selection=$(echo -e "$prompts" | rofi -dmenu -theme ~/.config/rofi/simple.rasi)
else
  selection=$(echo -e "$prompts" | rofi -dmenu) # use default config if no simple config was made before
fi

# in case this theme was already selected we do nothing
if echo "$selection" | grep -q "\*"; then
  exit 0
fi

# we delete "*"(mark symbol) from previous selection and add it to the new one
prompts=$(echo "$prompts" | sed "s/ \*//g" | sed "s/$selection/$selection \*/g")
echo "$prompts" > ~/.veu-toolbox/.prompts-list

base_dir=$(cat ~/.veu-toolbox/.main-dir-location)

# we add the necessary links to use this theme for configuration
rm ~/.config/starship
ln -s "$base_dir/configs/starship/$selection" ~/.config/starship
