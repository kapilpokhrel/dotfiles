#!/bin/bash

files=($(echo $HOME)/wallpapers/*.png)
random_file=${files[RANDOM % ${#files[@]}]}
echo "Picked: $random_file"

swww img -t "none" $random_file
matugen -t scheme-neutral image $random_file
