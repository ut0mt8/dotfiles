#!/bin/bash

if [ "$SELECTED" = "true" ]; then
  sketchybar --set $NAME label.highlight=on icon.highlight=on 
else
  sketchybar --set $NAME label.highlight=off icon.highlight=off
fi
