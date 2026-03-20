#!/usr/bin/env bash
# CPU usage zero-padded to 3 digits for Waybar

usage=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2 + $4)}')
printf '{"text": "%03d%%", "class": "%s"}\n' \
    "$usage" \
    "$([ "$usage" -ge 90 ] && echo "critical" || ([ "$usage" -ge 75 ] && echo "warning" || echo ""))"
