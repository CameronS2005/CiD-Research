#!/bin/bash
## this script is very outdated... but still works because of the simple nature... still needs a revamp!
## NOTES
##
## for some reason spoof rl has a misconfigured looking output (still works but looks like shit....)
##
##
##
##
##
##
##
##
##
# logger_file
logger_file="/var/log/pbx_cust.log" # logger disabled
### // config
ext="420"
randpre="1740279" # (random cid prefix)
#
cid_list_dir="/root/cids/"
#
example_usage="$0 rl ohio_rand , $0 r , $0 17405551234"
### endregion


##################################################################################################### // start of script
############# // user input
if [[ -n "$1" ]]; then
cid=$1
cli="true"
else
echo "Source CiD: Custom CiD, Random(r), Random From List(rl)"
read -r cid
if [[ $cid == "rl" ]]; then
    echo "CiD Lists: "
    for entry in `ls $cid_list_dir`; do
    echo $entry
    done
    echo "Select CiD List:"
    read -r list
fi; fi
############# endregion


###################### // random cid
if [[ $cid == "r" ]]; then
var="true"
randsuf=$(shuf -i 1000-9999 -n1) # (random cid suffix)
cid=$randpre$randsuf
#
asterisk -x "database put AMPUSER/$ext outboundcid $cid" &> /dev/null # commeted out null incase output is a failure
#
echo "Set CiD To: $cid For Ext: $ext"
exit 0
fi
###################### endregion


####################### // random from list cid
if [[ $cid == "rl" ]]; then
cid_list_file=$2
cid_list=$cid_list_dir$cid_list_file$list
if [ ! -f "$cid_list" ]; then
echo "ERROR! CiD List File Doesn't Exist!"
echo "Current CiD File $cid_list"
exit 0
fi
#
cid=$(shuf -n 1 "$cid_list")
#
    asterisk -x "database put AMPUSER/$ext outboundcid $cid" &> /dev/null  # commeted out null incase output is a failure
#
    echo "Set CiD To: $cid For Ext: $ext"
    echo "$(date) :: EXT $ext CID SPOOFED TO $cid" | tee -a $logger_file &> /dev/null # logger
exit 0
fi
####################### endregion


################################################# // custom cid
if [[ $cid -gt "1" ]]; then # checks for valid cid number
    if [[ $var != "true" ]]; then
        asterisk -x "database put AMPUSER/$ext outboundcid $cid" &> /dev/null # commeted out null incase output is a failure
        #
        echo "Set CiD To: $cid For Ext: $ext"
        echo "$(date) :: EXT $ext CID SPOOFED TO $cid" | tee -a $logger_file &> /dev/null # logger
        exit 0
fi;fi
################################################# endregion


##################################### // invalid input
echo "ERROR! $cid IS AN INVALID INPUT!"; echo ""
echo "$example_usage"
exit 0
##################################### endregion


##################################################################################################### endregion
