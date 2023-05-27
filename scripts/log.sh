#!/bin/bash

# log files # need to hardcode support for flood log and incoming call log
# example usage

### user input
# what does user want to do with the log
if [[ -z $1 ]]; then
echo "Do You Want To Clear Or View Log File"
echo "ENTER C / V / VN (Or VN To View Only New Log Entries)"
read -r var2
echo ""
else
var2=$1
fi
# selecting with log file to manage
if [[ -z $2 ]]; then
echo "Select Log File; (1, 2, 3)"
echo "---"
echo "1: pbx_custom"
echo "2: flood_attempts"
echo "---"
echo "Log #: "
read -r var1
echo ""
else
var1=$2
fi; if [[ $var1 == "1" ]]; then
log="/var/log/pbx_cust.log"
elif [[ $var1 == "2" ]]; then
log="/var/log/flood_log.log"
else
	echo "INVALID ENTRY!"
	exit 0
fi
###

#
if [[ ! -f $log ]]; then
touch $log
fi
#

### clear log (var = C)
if [[ $var2 == "C" || $var2 == "c" ]]; then
	echo "" > $log
	clear
	echo "Log File Cleared! $log"
	exit 0
### endregion

### view new entries (var = VN) (new entries)
elif [[ $var2 == "VN"|| $var2 == "vn" ]]; then
	clear
	echo "Viewing New Log Entries! $log"
	tail -f -n 0 $log
	exit 0
### endregion

### view log (var = V)
elif [[ $var2 == "V" || $var2 == "v" ]]; then
	clear
	echo "Viewing Log Entries! $log"
	tail -f $log
	exit 0
else
	echo "INVALID ENTRY!"
	exit 0
fi
### endregion