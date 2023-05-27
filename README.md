# CiD-Research
Caller ID Spoofer & Flooder Simulation Project! These are not meant to be used to cause damage nor to be used in any illegal way, and only to be used in a controlled environment!

All these scripts are configured to run on an Asterisk 18 & Freepbx Install!

## https://computingforgeeks.com/how-to-install-with-freepbx-on-ubuntu/

They will also work on a Raspberry Pi running Raspbx, or standalone linux on a raspberry pi running the same Asterisk & Freepbx install!

## http://www.raspberry-asterisk.org/

----------------------------------------------------

echo0nano.sh; I mainly only used this script for development & testing, so it doesnt have much to do with the spoofer or the flooder but its helpful, it simples empties a file and throws you in a nano sessions to paste a new version! It's meant to be set to a static bin location in your .profile so you can simple run "eon FILE !" to paste the new version! << SAVES ME A ALOT OF TIME!!

flood.sh; Custom flood script! Usage; ./flood 15552120123 0

flood_l.sh; Custom flood script! (This script will use random CiD's from a list instead of using a static prefix and random suffix like flood.sh!) Usage; ./flood_l.sh 15152120123 0 new_york_insurance.txt

log.sh; Some of these scripts create log events in a custom log file that can be managed with this script! Usage; ./log

screen-flood.sh; Simple script to screen a flood!

spoof.sh; Simple script to spoof the CiD on an Extension!
