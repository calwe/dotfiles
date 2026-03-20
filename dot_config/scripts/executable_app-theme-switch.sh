#!/bin/bash
CHEZMOI_SOURCE="$HOME/.local/share/chezmoi"
THEMES_DIR="$CHEZMOI_SOURCE/themes"
THEME_DATA="$CHEZMOI_SOURCE/.chezmoidata/theme.yaml"

APPS=("kitty" "neovim" "waybar")

selected_app=$(printf '%s\n' "${APPS[@]}" | rofi -dmenu -p "App" -i)
[ -z "$selected_app" ] && exit 0

# Discover themes (folders = has subthemes, yaml files = no subthemes)
themes=()
for item in "$THEMES_DIR"/*; do
    [ -e "$item" ] || continue
    name=$(basename "$item")
    [[ "$name" == *.yaml ]] && themes+=("${name%.yaml}") || themes+=("$name")
done

selected_theme=$(printf '%s\n' "${themes[@]}" | rofi -dmenu -p "$selected_app theme" -i)
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

# Merge theme data into app-specific keys in theme.yaml
# Global data is preserved; only the app-prefixed keys are updated
yq '.' "$THEME_DATA" | jq \
    --arg app "$selected_app" \
    --argjson theme "$(yq '.' "$yaml_file")" \
    '. + {
      ($app + "_colors"):  $theme.colors,
      ($app + "_neovim"):  $theme.neovim,
      ($app + "_waybar"):  $theme.waybar
    }' | yq -y '.' > "$THEME_DATA.new" && mv "$THEME_DATA.new" "$THEME_DATA"

chezmoi apply

# Reload only the selected app
case "$selected_app" in
    kitty)  kill -SIGUSR1 $(pidof kitty) 2>/dev/null ;;
    waybar) pkill -SIGUSR2 waybar 2>/dev/null ;;
    neovim) ;; # takes effect on next launch
esac
