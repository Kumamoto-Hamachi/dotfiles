#!/usr/bin/env bash
# 2画面のwindowをswapするスクリプト, 独自のショートカットとしてctrl + alt + sで起動するようにしている
# Set the display width (adjust this based on your setup; for example, 1920 if you use Full HD)
DISPLAY_WIDTH=1920
# Get a list of all window IDs and their current positions
ALL_WINDOWS=$(wmctrl -lG | awk '{print $1, $3}')
# Loop through each window and swap displays
while read -r WINDOW_ID X_POS; do
    if [ "$X_POS" -lt "$DISPLAY_WIDTH" ]; then
        # Window is on Display A (left), move it to Display B (right)
        xdotool windowmove $WINDOW_ID $DISPLAY_WIDTH 0
    else
        # Window is on Display B (right), move it to Display A (left)
        xdotool windowmove $WINDOW_ID 0 0
    fi
done <<< "$ALL_WINDOWS"

