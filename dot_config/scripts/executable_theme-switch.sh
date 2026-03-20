#!/bin/bash
CHEZMOI_SOURCE="$HOME/.local/share/chezmoi"
THEMES_DIR="$CHEZMOI_SOURCE/themes"
THEME_DATA="$CHEZMOI_SOURCE/.chezmoidata/theme.yaml"

# Discover themes (folders = has subthemes, yaml files = no subthemes)
themes=()
for item in "$THEMES_DIR"/*; do
    [ -e "$item" ] || continue
    name=$(basename "$item")
    [[ "$name" == *.yaml ]] && themes+=("${name%.yaml}") || themes+=("$name")
done

selected_theme=$(printf '%s\n' "${themes[@]}" | rofi -dmenu -p "Theme" -i)
[ -z "$selected_theme" ] && exit 0

theme_path="$THEMES_DIR/$selected_theme"
if [ -d "$theme_path" ]; then
    subthemes=()
    for f in "$theme_path"/*.yaml; do
        subthemes+=("$(basename "${f%.yaml}")")
    done
    selected_subtheme=$(printf '%s\n' "${subthemes[@]}" | rofi -dmenu -p "$selected_theme style" -i)
    [ -z "$selected_subtheme" ] && exit 0
    yaml_file="$theme_path/$selected_subtheme.yaml"
else
    yaml_file="$theme_path.yaml"
    selected_subtheme=""
fi

# Save existing per-app overrides before overwriting
yq '.' "$THEME_DATA" | jq '{kitty_colors, kitty_neovim, kitty_waybar, waybar_colors, waybar_neovim, waybar_waybar, neovim_colors, neovim_neovim, neovim_waybar}' > /tmp/per-app.json 2>/dev/null

# Write new theme data
yq '. + {theme: "'"$selected_theme"'", subtheme: "'"$selected_subtheme"'"}' \
    "$yaml_file" > "$THEME_DATA"

# Restore per-app overrides
yq '.' "$THEME_DATA" | jq --argjson perapp "$(cat /tmp/per-app.json)" '. * $perapp' \
    > "$THEME_DATA.new" && mv "$THEME_DATA.new" "$THEME_DATA"
rm -f /tmp/per-app.json

# Regenerate all templates (includes custom-minimal.css via chezmoi)
chezmoi apply

update_obsidian_theme() {
    local theme="$1"
    local subtheme="$2"
    local settings="$HOME/vault/.obsidian/plugins/obsidian-minimal-settings/data.json"

    [ -f "$settings" ] || return 0

    local dark_scheme="" light_scheme=""

    case "$theme" in
        rosepine)
            if [ "$subtheme" = "dawn" ]; then
                dark_scheme="minimal-rose-pine-light"
                light_scheme="minimal-rose-pine-light"
            else
                dark_scheme="minimal-rose-pine-dark"
                light_scheme="minimal-rose-pine-light"
            fi ;;
        catppuccin)
            if [ "$subtheme" = "latte" ]; then
                dark_scheme="minimal-catppuccin-light"
                light_scheme="minimal-catppuccin-light"
            else
                dark_scheme="minimal-catppuccin-dark"
                light_scheme="minimal-catppuccin-light"
            fi ;;
        everforest)
            if [ "$subtheme" = "light" ]; then
                dark_scheme="minimal-everforest-light"
                light_scheme="minimal-everforest-light"
            else
                dark_scheme="minimal-everforest-dark"
                light_scheme="minimal-everforest-light"
            fi ;;
        gruvbox)
            if [ "$subtheme" = "light" ]; then
                dark_scheme="minimal-gruvbox-light"
                light_scheme="minimal-gruvbox-light"
            else
                dark_scheme="minimal-gruvbox-dark"
                light_scheme="minimal-gruvbox-light"
            fi ;;
        nord)
            dark_scheme="minimal-nord-dark"
            light_scheme="minimal-nord-light" ;;
        dracula)
            dark_scheme="minimal-dracula-dark"
            light_scheme="minimal-dracula-dark" ;;
        ayu)
            if [ "$subtheme" = "light" ]; then
                dark_scheme="minimal-ayu-light"
                light_scheme="minimal-ayu-light"
            else
                dark_scheme="minimal-ayu-dark"
                light_scheme="minimal-ayu-light"
            fi ;;
        solarized)
            if [ "$subtheme" = "light" ]; then
                dark_scheme="minimal-solarized-light"
                light_scheme="minimal-solarized-light"
            else
                dark_scheme="minimal-solarized-dark"
                light_scheme="minimal-solarized-light"
            fi ;;
        aura|kanagawa|oxocarbon|onedark|nightfox)
            dark_scheme="custom-minimal"
            light_scheme="custom-minimal" ;;
        *) return 0 ;;
    esac

    local tmp
    tmp=$(mktemp)
    jq --arg dark "$dark_scheme" --arg light "$light_scheme" \
        '.darkScheme = $dark | .lightScheme = $light' \
        "$settings" > "$tmp" && mv "$tmp" "$settings"
}

update_wallpaper() {
    local theme="$1"
    local subtheme="$2"
    local wallpaper_dir="$HOME/.config/niri/wallpapers"
    local wallpaper=""

    case "$theme" in
        catppuccin)
            [ "$subtheme" = "latte" ] && wallpaper="catppuccin-latte.jpg" || wallpaper="catppuccin.jpg" ;;
        rosepine)
            [ "$subtheme" = "dawn" ] && wallpaper="rosepine-dawn.jpg" || wallpaper="rosepine.jpg" ;;
        gruvbox)
            [ "$subtheme" = "light" ] && wallpaper="gruvbox-light.jpg" || wallpaper="gruvbox.jpg" ;;
        gruvbox-material)
            [ "$subtheme" = "light" ] && wallpaper="gruvbox-light.jpg" || wallpaper="gruvbox.jpg" ;;
        everforest)
            [ "$subtheme" = "light" ] && wallpaper="everforest-light.jpg" || wallpaper="everforest.jpg" ;;
        kanagawa)
            [ "$subtheme" = "lotus" ] && wallpaper="kanagawa-light.jpg" || wallpaper="kanagawa.jpg" ;;
        tokyonight)
            [ "$subtheme" = "day" ] && wallpaper="tokyonight-light.jpg" || wallpaper="tokyonight.jpg" ;;
        ayu)
            [ "$subtheme" = "light" ] && wallpaper="ayu-light.jpg" || wallpaper="ayu.jpg" ;;
        solarized)
            [ "$subtheme" = "light" ] && wallpaper="solarized-light.jpg" || wallpaper="solarized.jpg" ;;
        oxocarbon)
            [ "$subtheme" = "light" ] && wallpaper="oxocarbon-light.jpg" || wallpaper="oxocarbon.jpg" ;;
        nord)      wallpaper="nord.jpg" ;;
        dracula)   wallpaper="dracula.jpg" ;;
        onedark)   wallpaper="onedark.jpg" ;;
        nightfox)  wallpaper="nightfox.jpg" ;;
        aura)      wallpaper="aura.jpg" ;;
        *) return 0 ;;
    esac

    local full_path="$wallpaper_dir/$wallpaper"
    [ -f "$full_path" ] || return 0

    ln -sf "$full_path" "$wallpaper_dir/current"
    systemctl --user restart swaybg 2>/dev/null || {
        pkill swaybg 2>/dev/null || true
        swaybg -m fill -i "$full_path" &
        disown
    }
}

# Reload applications (no restarts that would lose state)
pkill -SIGUSR2 waybar 2>/dev/null          # waybar reloads CSS
kill -SIGUSR1 $(pidof kitty) 2>/dev/null   # kitty reloads config
makoctl reload 2>/dev/null                 # mako reloads config
niri msg action reload-config 2>/dev/null  # niri reloads config
tmux source-file ~/.tmux.conf 2>/dev/null  # tmux sources new config
update_obsidian_theme "$selected_theme" "$selected_subtheme"
update_wallpaper "$selected_theme" "$selected_subtheme"
# Neovim: takes effect on next launch
