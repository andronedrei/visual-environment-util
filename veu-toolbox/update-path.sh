#!/bin/bash

# proper work of scripts and config files is dependent on proper use of current user home
# use this script if the utility is copied to an other file or user updated

# ONLY USE THIS SCRIPT WHEN YOU ARE IN ITS DIRECTORY LOCATION
# DO NOT USE THIS SCRIPT FROM ~/.veu-toolbox as it will break (veu-toolbox is a simbolic link to the real script location)

cur_loc=$(pwd)
if [ "$cur_loc" == "/home/$USER/.veu-toolbox" ]; then
    echo "Error: RUN THIS SCRIPT FROM THE ORIGINAL DIRECTORY THAT CONTAINS IT"
    exit 1
fi

last_dir=$(basename "$cur_loc")
if [ "$last_dir" != "veu-toolbox" ]; then
    echo "Error: RUN THIS SCRIPT FROM THE ORIGINAL DIRECTORY THAT CONTAINS IT"
    exit 1
fi

update_path() {
    local FILE="$1"

    # Check if the file is readable
    if [ -r "$FILE" ]; then
        # Replace the specified pattern with the $USER variable
        sed -i -E "s#/home/[a-zA-Z0-9._-]+/.config#/home/$USER/.config#g" "$FILE"
    fi
}

cd ..
utility_base_dir_loc=$(pwd)

# find all .jsonc and .css files, excluding .git directory
FILES=$(find . -type f -not -path '*/.git/*' -name "*.jsonc" -o -name "*.css")

# iterate over the files, handling spaces in filenames
while IFS= read -r FILE; do
    update_path "$FILE"
done <<< "$FILES"

cd veu-toolbox

# updating the symbolic link for hypr configuration
rm -r ~/.config/hypr
ln -s "$utility_base_dir_loc/configs/hypr" ~/.config/hypr

# update the file that stores the location of the main dir of the utility
echo "$utility_base_dir_loc" > .main-dir-location

# update veu-toolbox easy acces simbolic link
rm ~/.veu-toolbox
ln -s "$cur_loc" ~/.veu-toolbox

# update path for essential scripts from this utility that are also used by "run-computer-script.sh"
nr_veu_scripts="4" # first 4 are the essential scripts
veu_essential=$(head -n "$nr_veu_scripts" ~/.veu-toolbox/computer-scripts-list.txt)
others=$(tail -n +"$((nr_veu_scripts + 1))" ~/.veu-toolbox/computer-scripts-list.txt)

veu_essential=$(echo "$veu_essential" | xargs -n 1 basename)

new_veu_essential=""
for item in $veu_essential; do
    new_veu_essential+="$cur_loc/$item"$'\n'
done
new_veu_essential=$(echo "$new_veu_essential" | sed 's/\n$//') # remove trailing emptyline

echo "$new_veu_essential" > computer-scripts-list.txt
echo -n "$others" >> computer-scripts-list.txt
cat computer-scripts-list > .computer-scripts-list.backup
