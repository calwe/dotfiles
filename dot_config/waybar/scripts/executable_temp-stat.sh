#!/usr/bin/env bash
# CPU temperature zero-padded to 3 digits for Waybar
# Reads from the same hwmon path used in the original temperature module

hwmon_path="/sys/class/hwmon/hwmon3/temp3_input"

if [ -r "$hwmon_path" ]; then
    raw=$(cat "$hwmon_path")
    temp=$(( raw / 1000 ))
else
    # fallback: try sensors command
    temp=$(sensors 2>/dev/null | awk '/^Package id 0|^Tdie|^CPU Temperature/ {gsub(/[^0-9.]/, "", $NF); printf "%d", $NF; exit}')
    temp=${temp:-0}
fi

printf '{"text": "%03d°C", "class": "%s"}\n' \
    "$temp" \
    "$([ "$temp" -ge 90 ] && echo "critical" || echo "")"
