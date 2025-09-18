#!/bin/bash

files=($(echo $HOME)/wallpapers/*.png)
random_file=${files[RANDOM % ${#files[@]}]}
echo "Picked: $random_file"

swww -t "none" img $random_file
matugen -t scheme-neutral image $random_file
