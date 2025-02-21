#!/bin/bash

# proper work of scripts and config files is dependent on proper use of current user home
# use this script if the utility is copied to an other file or user updated

# DO NOT USE THIS SCRIPT FROM ~/.veu-toolbox as it will break (veu-toolbox is a simbolic link to the real script location)

update_path() {
    local FILE="$1"

    # Check if the file is readable
    if [ -r "$FILE" ]; then
        # Replace the specified pattern with the $USER variable
        sed -i -E "s#/home/[a-zA-Z0-9._-]+/.config#/home/$USER/.config#g" "$FILE"
    fi
}

cd ..

# find all .jsonc and .css files, excluding .git directory
FILES=$(find . -type f -not -path '*/.git/*' -name "*.jsonc" -o -name "*.css")

# iterate over the files, handling spaces in filenames
while IFS= read -r FILE; do
    update_path "$FILE"
done <<< "$FILES"

cd veu-toolbox

# update veu-toolbox easy acces path
rm ~/.veu-toolbox
ln -s "$(pwd)" ~/.veu-toolbox

# update path for essential scripts from this utility that are also used by "run-computer-script.sh"
nr_veu_scripts="2"
veu_essential=$(head -n "$nr_veu_scripts" ~/.veu-toolbox/computer-scripts-list)
others=$(tail -n +"$((nr_veu_scripts + 1))" ~/.veu-toolbox/computer-scripts-list)

cur_loc=$(pwd)
veu_essential=$(echo "$veu_essential" | xargs -n 1 basename)

new_veu_essential=""
for item in $veu_essential; do
    new_veu_essential+="$cur_loc/$item"$'\n'
done
new_veu_essential=$(echo "$new_veu_essential" | sed 's/\n$//') # remove trailing emptyline

echo "$new_veu_essential" > computer-scripts-list
echo "$others" >> computer-scripts-list
cat computer-scripts-list > computer-scripts-list.backup 
