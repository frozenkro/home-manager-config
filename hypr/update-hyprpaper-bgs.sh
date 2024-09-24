#!/bin/bash
echo help
echo home: $HOME
echo 1: $1

if [ -z "$1" ]
then
  echo hello
  hd=$HOME
else 
  hd=$1
fi

directory=$hd/Pictures/hyprpaper-rotation
monitors=$(hyprctl monitors | grep Monitor | awk '{print $2};')


if [ -d "$directory" ]; then

  hyprctl hyprpaper unload all

  while IFS= read -r monitor; do
    echo $monitor
    bg_filename=$(ls $directory | shuf -n 1)
    bg_path=$directory/$bg_filename

    hyprctl hyprpaper preload $bg_path
    hyprctl hyprpaper wallpaper "$monitor, $bg_path"
  done <<< "$monitors"
fi

