#! /bin/bash

variable1="FortiFlex Serial Number"

###### Display Help ######
Help()
{
  # Display Help
  echo
  echo "-----"
  echo "Usage"
  echo "-----"
  echo "$0 [$variable1]" 
  echo " " 
  echo "Example 1:  $0  <cut paste $variable1>" 
  echo " "
} 

##########   Start   ############
##### Identify Argument Flags ####
while getopts :h flag
do 
  case "${flag}" in
    h) # display Help
	Help
	exit;; 
    \?) # Invalid option
	echo Invalid Option !!	
	Help	
	exit;; 
  esac
done
if (($# != 1))
then
   echo "Number of arguments should be 1"
   Help
   exit
fi
##########    End    ############
##### Identify Arguent Flags ####
echo "$variable1  : $1";

### Enable verbose execution of script ###
set -v

sed -i "/fortiflex_SN/c\  fortiflex_SN: \"$1\"" global.yml 
