#!/bin/sh

VOLUME="$INFO"

# INFO is only populated by volume_change. Startup/reload uses a forced update,
# so query macOS directly when INFO is missing (also covers device switches).
case "$VOLUME" in
''|*[!0-9]*)
  VOLUME=$(osascript \
    -e 'set volumeSettings to get volume settings' \
    -e 'if output muted of volumeSettings then return 0' \
    -e 'return output volume of volumeSettings' 2>/dev/null)
  ;;
esac

# Some digital outputs do not expose software volume; keep the previous value.
case "$VOLUME" in
''|*[!0-9]*) exit 0 ;;
esac

case "$VOLUME" in
0)
  ICON=""
  ICON_PADDING_RIGHT=21
  ;;
[0-9])
  ICON=" "
  ICON_PADDING_RIGHT=12
  ;;
*)
  ICON=" "
  ICON_PADDING_RIGHT=6
  ;;
esac

sketchybar --set "$NAME" \
  icon="$ICON" \
  icon.padding_right="$ICON_PADDING_RIGHT" \
  label="${VOLUME}%"
