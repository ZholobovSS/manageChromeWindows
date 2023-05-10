#!/usr/bin/env bash


# VARIABLES

TAB_1_LINK="URL for first tab"
TAB_2_LINK="URL for second tab"


# IF DISPLAY VARIABLE NOT SET

if [[ -z $DISPLAY ]] ; then
    export DISPLAY=:0
fi


# GET CHROME WINDOW IDS

CHROME_WINDOW_IDS=$(xdotool search --onlyvisible --name chrome)




# OPEN CHROME WINDOWS BY CONDITION

if [[ set here some condition to open windows ]] ; then
    echo "Open chrome windows"
    google-chrome --new-window ${TAB_1_LINK} &
    sleep 5
    google-chrome --new-window ${TAB_2_LINK} &
    sleep 5
    
    xdotool windowmove $(xdotool search --onlyvisible --name chrome | head -1) 0 0
    xdotool windowsize $(xdotool search --onlyvisible --name chrome | head -1) 2000 860
    
    xdotool windowmove $(xdotool search --onlyvisible --name chrome | tail -1) 0 860
    xdotool windowsize $(xdotool search --onlyvisible --name chrome | tail -1) 2000 1650
    
    exit 0;
fi



# CLOSE ALL CHROME WINDOWS BY CONDITION

if [[ set here some condition to close all windows  ]] ; then
    echo "Close all chrome windows"
    killall chrome
fi
