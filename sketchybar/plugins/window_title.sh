#!/bin/bash

TITLE=$(/opt/homebrew/bin/yabai -m query --windows --window | jq -r '.title')
APP=$(/opt/homebrew/bin/yabai -m query --windows --window | jq -r '.app')

if [ "${TITLE}" == "" ]; then
  WINDOW_TITLE="${APP}"
else
  WINDOW_TITLE="${APP} - ${TITLE}"
fi	

if [[ ${#WINDOW_TITLE} -gt 50 ]]; then
  WINDOW_TITLE=$(echo "$WINDOW_TITLE" | cut -c 1-50)
  sketchybar -m --set title label="$WINDOW_TITLE"…
  exit 0
fi

sketchybar -m --set title label="$WINDOW_TITLE"
