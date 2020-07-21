#!/bin/bash
function copyone {
    find "$1" \( -name "*.css" -o -name "*.html"  -o -name "*.png"  -o -name "*.jpg"  -o -name "*.svg" \) -maxdepth 3 |while read file; do  
        echo "$file"
        filem="${file/Writings/ishanlevy.github.io}"
        fold=$(dirname "$filem")
        echo mkdir -p "$fold"
        echo cp "$file $filem"
        mkdir -p "$fold"
        cp "$file" "$filem"
    done
}
function copyall {
find ./Writings -name "*exceptions.txt" -maxdepth 3 |while read file; do  
    metafolder="$(dirname "${file}")"
    echo "$metafolder"
    arr=()
    while IFS= read -r line; do
        arr+=("$line")
    done < "$file"
    find "$metafolder" -mindepth 1 -maxdepth 1 -type d|while read folder; do
        echo "$folder"
        alreadyfound=0
        for i in "${arr[@]}"; do
            if [ "$i" == "${folder##*/}" ] ; then
                alreadyfound=1
                echo "excluded"
            fi
        done
        if [ $alreadyfound == 0 ]; then
            echo copyone "$folder"
            copyone "$folder"
        fi
    done
done
}



