#!/bin/bash

## flood screen script
##
## make as cli only script (non cli with no error outputs configured for screened api floods) 
##
##
##
##
##
##
##
floodlocation="/root/bins/fl"
floodlocation_l="/root/bins/fl_l"
##

if [[ -z $3 ]]; then
screen -dmS "flood_atk" bash $floodlocation "$1" "$2" # $1 = tnum, $2 = calls
else
screen -dmS "flood_atk" bash $floodlocation_l "$1" "$2" "$3" # $1 = tnum, $2 = calls, $3 = cid list
fi
if [[ $2 == "0" ]]; then
	calls="infinite"
else
	calls=$2
fi; if [[ -z $3 ]]; then
echo "Call Flood Started On $1 RND (Calls: $calls)"
else
echo "Call Flood Started On $1 With List $3 (Calls: $calls)"
fi