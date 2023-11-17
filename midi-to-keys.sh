#!/bin/bash
# Map MIDI keys into keystrokes in Wayland using ydotool
# Look keycodes in  /usr/include/linux/input-event-codes.h
# To run ydotool, add user to input group:
#   groupadd -f input
#   sudo usermod -a -G input $USER
aseqdump -p "LPD8" | \
while IFS=" ," read src ev1 ev2 ch label1 data1 label2 data2 rest; do
    case "$ev1 $ev2 $data1" in
        "Note on 41" ) ydotool key 103:1 103:0 ;; # UP
        "Note on 36" ) ydotool key 105:1 105:0 ;; # LEFT
        "Note on 37" ) ydotool key 108:1 108:0 ;; # DOWN
        "Note on 38" ) ydotool key 106:1 106:0 ;; # RIGHT
        "Note on 43" ) ydotool type "\mathbf" ;;
    esac
done

