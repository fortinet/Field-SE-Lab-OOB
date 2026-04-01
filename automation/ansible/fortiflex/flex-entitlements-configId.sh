#! /bin/bash

yml_file="$(echo "$0" | sed 's/\(.*\)\..*/\1/').yml"
variable1="configId"

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
  echo "Example 1:  $0 41057"  
  echo "Example 2:  $0 41504" 
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

echo "$yml_file.yml"

ansible-playbook $yml_file --extra-vars "fortiflex_configId=$1"
