#!/bin/bash


BATT_PERCENT=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

sketchybar -m --set battery icon.color=0xff989898

if [[ ${CHARGING} != "" ]]; then
  sketchybar -m --set battery icon=󰂄
  sketchybar -m --set battery label="${BATT_PERCENT}%" 
  exit 0
fi

case ${BATT_PERCENT} in
    100) ICON="󰁹" ;;
    9[0-9]) ICON="󰂂" ;;
    8[0-9]) ICON="󰂁" ;;
    7[0-9]) ICON="󰂀" ;;
    6[0-9]) ICON="󰁿" ;;
    5[0-9]) ICON="󰁾" ;;
    4[0-9]) ICON="󰁽" ;;
    3[0-9]) ICON="󰁻" ;;
    2[0-9]) ICON="󰁺" ;;
    1[0-9]) ICON="󰁺" ;;
    *) ICON="󰁹"
esac

sketchybar -m --set battery icon=${ICON}
sketchybar -m --set battery label="${BATT_PERCENT}%" 

