#!/usr/bin/env bash
# Memory usage zero-padded to 3 digits for Waybar

read -r total used <<< "$(free -m | awk '/^Mem:/ {print $2, $3}')"
pct=$(( used * 100 / total ))
printf '{"text": "%03d%%", "class": "%s"}\n' \
    "$pct" \
    "$([ "$pct" -ge 90 ] && echo "critical" || ([ "$pct" -ge 75 ] && echo "warning" || echo ""))"
