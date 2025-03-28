#!/bin/sh

sketchybar -m --set "$NAME" label="$(top -l 2 | grep -E "^CPU" | tail -1 | awk '{usage = $3 + $5; if (usage < 10) printf "%.2f%%", usage; else printf "%.1f%%", usage}')"
