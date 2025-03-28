#!/bin/sh

sketchybar --set $NAME label="$(LC_TIME=zh_CN.UTF-8 date '+周%a%b/%-d %-H:%M')"
