#!/bin/sh

# Set icons for common workspaces
ICON_PADDING_LEFT=7
ICON_PADDING_RIGHT=7
case "$1" in
U)
  ICON=
  ICON_PADDING_LEFT=5
  ICON_PADDING_RIGHT=4
  ;;
I)
  ICON=
  ICON_PADDING_LEFT=7
  ICON_PADDING_RIGHT=6
  ;;
O)
  ICON=󰅶
  ;;
P)
  ICON=󰝚
  ;;
*)
  ICON=$1
  ICON_PADDING_LEFT=10
  ICON_PADDING_RIGHT=10
  ;;
esac
sketchybar --set $NAME \
  icon=$ICON \
  icon.padding_left=$ICON_PADDING_LEFT \
  icon.padding_right=$ICON_PADDING_RIGHT

# Hightlight if selected
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME background.drawing=on
else
  sketchybar --set $NAME background.drawing=off
fi
