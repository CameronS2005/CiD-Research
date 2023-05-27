#!/bin/bash

##
## cli key is current day of the month to prevent errors (set on line 16)
# 
# logger_file
logger_file="/var/log/pbx_cust.log" # logger disabled
##
##
##
##
##
##
##
bypasskey="!" # bypasses usage: ./eon file bypasskey
##


############# start (HARDCODED SAFTEY BYPASS) usage: ./eon file !
if [[ $2 == "$bypasskey" ]]; then
var="Y"
file=$1
else
#############


######### start (VERY DANGEROUS SECTION USED FOR CLI CMDS)
if [[ $1 != "" ]]; then
	dom=$(date +%d) # sets cli key as day of month (dom)
if [[ $1 != "$dom" ]]; then
echo "$1 Is An Invalid Key! Exiting! ($dom)"
exit 0
else
	echo "Are You Sure You Want To Erase $2"
	echo "Y/N"
	read -r var2
if [[ $var2 != "Y" ]]; then
echo "User Denied Var! Exiting!"
exit 0
else
	var="Y"
	file=$2
fi; fi; fi; fi
######### endregion


### start user input
if [[ $var != "Y" ]]; then
echo "WARNING! THIS SCRIPT WILL ERASE THE CONTENTS OF THE FILE YOU INPUT!" #; echo ""
echo "THIS SCRIPT IS VERY DANGEROUS AND CAN RUIN YOUR SYSTEM IF USED WRONG!"
echo "Enter File Name or File Path: "
read -r file
# verify user knows what they are doing!
echo "Are You Sure You Want To Erase $file"
echo "Y/N"
read -r var
fi
### endregion


### start user input checks
if [[ $var != "Y" ]]; then
echo "User Denied Var! Exiting!"
exit 0
else
	if [[ $var == "Y" ]]; then
if [[ $file =~ .*"/".* ]]; then # if file user input contains a / thens 
filetype="dir-file" # triggers dir-file e0n
else 
filetype="file" # triggers file e0n
fi
### endregion


### start file e0n
if [[ $filetype == "file" ]]; then
file="$(pwd)/$file" # yes this actually works lol
echo "" > "$file"; nano "$file"; chmod +x "$file"
fi
### endregion


### start dir-file e0n
if [[ $filetype == "dir-file" ]]; then
#file="$(pwd)/$file"
echo "" > "$file"; nano "$file" #; chmod +x $file

fi; fi; fi
### endregion

echo "$(date) :: Echo0Nano Executed on $file" | tee -a $logger_file &> /dev/null #logging disabled because it clutters log file

##### end of script