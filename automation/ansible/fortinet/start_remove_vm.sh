#! /bin/bash

yml_file="start_remove_vm"

###### Display Help ######
Help()
{
  # Display Help
  echo
  echo "-----"
  echo "Usage"
  echo "-----"
  echo "$yml_file.sh [vars host file] [pve node] [group] [started | absent ]"
  echo " " 
  echo "Example 1:  $yml_file.sh  ../vars/all-hosts.yml pve03 fmg             started"
  echo "Example 2:  $yml_file.sh  ../vars/all-hosts.yml pve03 faz             started"
  echo "Example 3:  $yml_file.sh  ../vars/all-hosts.yml pve01 fortigate_sdwan absent"
  echo "Cannot use 'stopped'"
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
if (($# != 4))
then
   echo "Number of arguments should be 4"
   Help
   exit
fi
##########    End    ############
##### Identify Arguent Flags ####

echo "host_file        : $1";
echo "pve_node         : $2";
echo "group_name       : $3";
echo "start_stop       : $4";

### Enable verbose execution of script ###
set -v

ansible-playbook $yml_file.yml --extra-vars "host_vars_file=$1 pve_node=$2 group_name=$3 start_stop=$4"
