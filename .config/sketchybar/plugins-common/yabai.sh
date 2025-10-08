#!/bin/sh

ACTIVE_SPACE=$(yabai -m query --spaces --space | jq .index)

ICON_PADDING_LEFT=7
ICON_PADDING_RIGHT=7
case "$NAME" in
"space.1")
  ICON=
  ICON_PADDING_LEFT=5
  ICON_PADDING_RIGHT=4
  ;;
"space.2")
  ICON=
  ICON_PADDING_LEFT=7
  ICON_PADDING_RIGHT=6
  ;;
"space.3")
  ICON=󰅶
  ;;
"space.4")
  ICON=󰢹
  ;;
"space.5")
  ICON=󰝚
  ;;
*)
  ICON=${NAME##*.}
  ICON_PADDING_LEFT=10
  ICON_PADDING_RIGHT=10
  ;;
esac

if [ "$ACTIVE_SPACE" = "${NAME##*.}" ]; then
  sketchybar --set $NAME background.drawing=on
else
  sketchybar --set $NAME background.drawing=off
fi

sketchybar --set $NAME \
  icon=$ICON \
  icon.padding_left=$ICON_PADDING_LEFT \
  icon.padding_right=$ICON_PADDING_RIGHT
