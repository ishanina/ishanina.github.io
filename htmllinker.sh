#!/bin/bash
outfile="index.md"
echo > "$outfile"
find "." -mindepth 1 -maxdepth 1 -type d ! -name ".git"|while read folder; do
    echo "$folder"
    echo "## ${folder##*/}" >> "$outfile"
    find "$folder" -name "*.html" -maxdepth 3 |while read file; do  
        relpath="${file#*/}"
        linkname="${relpath#*/}"
        linkname="${linkname%/*}"
        echo "$relpath"
        echo "$linkname"
        pdflink="${file/.\//https://github.com/ishanina/PublicWritings/blob/master/}"
        pdflink=$(sed 's/ /%20/g' <<< "$pdflink")
        echo "$pdflink"
        echo "[$linkname]($relpath) [(pdf)]($pdflink)" >> "$outfile"
    done
done
