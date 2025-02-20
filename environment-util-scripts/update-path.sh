#!/bin/bash

# proper work of scripts and config files is dependent on proper use of current user home
# use this script if the utility is copied to an other file or user updated

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

cd environment-util-scripts