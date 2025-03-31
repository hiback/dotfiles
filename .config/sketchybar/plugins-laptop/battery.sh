#!/bin/sh

# Battery is here bcause the ICON_COLOR doesn't play well with all background colors

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ $PERCENTAGE = "" ]; then
  exit 0
fi

# Icon switch
case ${PERCENTAGE} in
9[5-9] | 100)
  ICON="󰁹"
  ;;
8[5-9] | 9[0-4])
  ICON="󰂂"
  ;;
7[5-9] | 8[0-4])
  ICON="󰂁"
  ;;
6[5-9] | 7[0-4])
  ICON="󰂀"
  ;;
5[5-9] | 6[0-4])
  ICON="󰁿"
  ;;
4[5-9] | 5[0-4])
  ICON="󰁾"
  ;;
3[5-9] | 4[0-4])
  ICON="󰁽"
  ;;
2[5-9] | 3[0-4])
  ICON="󰁼"
  ;;
1[5-9] | 2[0-4])
  ICON="󰁻"
  ;;
[5-9] | 1[0-4])
  ICON="󰁺"
  ;;
[0-4])
  ICON="󰂎"
  ;;
esac

if [ "$PERCENTAGE" -gt "20" ]; then
  ICON_COLOR=0xffa6e3a1
elif [ "$PERCENTAGE" -gt "10" ]; then
  ICON_COLOR=0xfff9e2af
else
  ICON_COLOR=0xfff38ba8
fi

if [[ $CHARGING != "" ]]; then
  ICON=""
  ICON_COLOR=0xfff9e2af
fi

sketchybar --set $NAME \
  icon=$ICON \
  label="${PERCENTAGE}%" \
  icon.color=${ICON_COLOR}
