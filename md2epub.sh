#!/bin/zsh

while getopts d: flag
do
    case "${flag}" in
        d) md_directory=${OPTARG};;
    esac
done
echo "Converting in directory: $md_directory";

md_directoryEscaped=$(printf %q "$md_directory")

# List of all markdown files
temp=filelist.cache

find "$md_directory" -name '*.md' -maxdepth 1 > $temp

while read file; do
    title=`echo ${file%.md}`
    file=`echo ${file%.md}`
    IFS='/' array=($title)
    #pandoc --from markdown --to epub3 "$file.md" --output "$file.epub" --toc
    pandoc --from markdown --to epub3 "$file.md" --output "$file.epub" --toc --metadata title="${array[${#array[@]}-1]}"
done <  $temp
#rm $temp
