#!/bin/bash

last_dir=$(basename "$PWD")
if [ "$last_dir" != "veu-toolbox" ]; then
    echo "Error: RUN THIS SCRIPT FROM THE ORIGINAL DIRECTORY THAT CONTAINS IT"
    exit 1
fi

sudo pacman -Syu
# installing hypr envirnment elements
echo "Installing hyprland required packages ..."
sleep 1
sudo pacman -S hyprland
sudo pacman -S rofi-wayland waybar chrono-date hyprpaper

# updating paths fot the location the util was downloaded to
./update-path
main_dir=$(cat .main-dir-location)

# writing the main hypr configuration
rm -r ~/.config/hypr
cp -r "$main_dir/configs/hypr" ~/.config

# write monitor name and resolution (!!! not reliable, check manually afterwards)
hyprctl monitors | grep "Monitor" | head -1 | awk '{print $2}' > .monitor 
hyprctl monitors | grep "@* at" | head -1 | sed 's/@.*//g' >> .monitor
sed -i 's/[[:space:]]//g' .monitor

echo "Do you want to use a different folder for your backgrounds ? (default one creeated for 2k monitors)"
echo "Type "yes" to do it or everything else to use default collection"
read use_custom_collection
if [ $use_custom_collection == "yes" ]; then
    echo "Specify custom collection folder absolute path (can also be modified later in ~/.veu-toolbox/.backgrounds-dir-location)"
    read custom-collection
    echo "$custom-collection" > .backgrounds-dir-location
else
    echo "$main_dir/backgrounds" > .backgrounds-dir-location
fi

# starship
echo "Installing starship ..."
sleep 1
sudo pacman -S starship
cp "$main_dir/configs/starship/blue-emoji-fun/starship.toml ~/.config/starship.toml

reboot
