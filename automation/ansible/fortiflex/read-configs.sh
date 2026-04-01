#! /bin/bash

yml_file="read-configs"

###### Display Help ######
Help()
{
  # Display Help
  echo
  echo "-----"
  echo "Usage"
  echo "-----"
  echo "$yml_file.sh [filename to read]"
  echo " " 
  echo "Example 1:  $yml_file.sh configs.txt" 
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

#echo "filename   : $1";

### Enable verbose execution of script ###
#set -v

python3 $yml_file.py $1 
