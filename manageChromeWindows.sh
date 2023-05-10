#!/usr/bin/env bash


# VARIABLES

TAB_1_LINK="URL for first tab"
TAB_2_LINK="URL for second tab "
TOKEN="This is additional variable. Depends on your specific task"
HA_ENTITY_ID="This is additional variable. Depends on your specific task"



# IF DISPLAY VARIABLE NOT SET

if [[ -z $DISPLAY ]] ; then
    export DISPLAY=:0
fi


# GET CHROME WINDOW IDS

CHROME_WINDOW_IDS=$(xdotool search --onlyvisible --name chrome)

# GET INFO ABOUT MONITOR

MONITOR_STATUS=$(curl --location "https://home.zh2s.ru/api/states/${HA_ENTITY_ID}" --header "Authorization: Bearer ${TOKEN}")


echo $CHROME_WINDOW_IDS $MONITOR_STATUS

# EXIT IF HA IS UNAVAILABLE

if [[ -z $MONITOR_STATUS ]] ; then
    exit 0;
fi



# OPEN CHROME WINDOWS IF MONITOR IS ON AND NO CHROME WINDOWS ARE OPEN

if [[ $MONITOR_STATUS =~ "state\":\"on" && -z $CHROME_WINDOW_IDS ]] ; then
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



# CLOSE CHROME IF MONITOR IS OFF

if [[ $MONITOR_STATUS  =~ "state\":\"off" ]] ; then
    echo "Close all chrome windows"
    killall chrome
fi
