#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/.wallpapers/"
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

echo $WALLPAPER
awww img "$WALLPAPER" --transition-type grow --transition-duration 2
