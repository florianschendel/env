#!/bin/zsh

while getopts d: flag
do
    case "${flag}" in d) md_directory=${OPTARG};;
    esac
done
echo "Converting in directory: $md_directory";

md_directoryEscaped=$(printf %q "$md_directory")

# List of all markdown files
temp=filelist.cache

find "$md_directory" -name '*.md' -maxdepth 1 > $temp

while read file; do
    titleName=`echo ${file%.md}`
    file=`echo ${file%.md}`
    basename "$titleName"
    title="$(basename -- $titleName)"
    pandoc --from markdown --to epub3 "$file.md" --output "$file.epub" --toc=true --metadata title=$title
done <  $temp
#rm $temp