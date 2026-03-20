#!/usr/bin/env bash

wallpaper_dir="$HOME/.config/niri/wallpapers"

# List image files, excluding the 'current' symlink
mapfile -t files < <(find "$wallpaper_dir" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | sort)

if [ ${#files[@]} -eq 0 ]; then
    exit 0
fi

# Build display names (basename without extension) and feed to rofi
declare -A name_to_path
display_names=()
for f in "${files[@]}"; do
    base=$(basename "$f")
    name="${base%.*}"
    name_to_path["$name"]="$f"
    display_names+=("$name")
done

selected=$(printf '%s\n' "${display_names[@]}" | rofi -dmenu -p "Wallpaper")
[ -z "$selected" ] && exit 0

full_path="${name_to_path[$selected]}"
[ -f "$full_path" ] || exit 1

ln -sf "$full_path" "$wallpaper_dir/current"
systemctl --user restart swaybg 2>/dev/null || {
    pkill swaybg 2>/dev/null || true
    swaybg -m fill -i "$full_path" &
    disown
}
