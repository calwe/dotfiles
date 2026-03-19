#!/bin/bash
# Create default wallpaper symlink if it doesn't already exist
wallpaper_dir="$HOME/.config/niri/wallpapers"
symlink="$wallpaper_dir/current"

if [ ! -L "$symlink" ] && [ -f "$wallpaper_dir/rosepine.jpg" ]; then
    ln -sf "$wallpaper_dir/rosepine.jpg" "$symlink"
fi
