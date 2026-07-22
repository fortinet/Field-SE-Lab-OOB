#! /bin/bash

yml_file="create_ubuntu_vm"

###### Display Help ######
Help()
{
  # Display Help
  echo
  echo "-----"
  echo "Usage"
  echo "-----"
  echo "$yml_file.sh [host vars file name] [pve node] [group]"
  echo " " 
  echo "Example 1:  $yml_file.sh  ../vars/all-hosts.yml pve02 ubuntu_sdwan"
  echo "Example 2:  $yml_file.sh  ../vars/all-hosts.yml pve01 ubuntu_other"
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
if (($# != 3))
then
   echo "Number of arguments should be 3"
   Help
   exit
fi
##########    End    ############
##### Identify Arguent Flags ####

echo "host_vars_file   : $1";
echo "pve_node         : $2";
echo "group_name       : $3";

### Enable verbose execution of script ###
set -v

ansible-playbook $yml_file.yml --extra-vars "host_vars_file=$1 pve_node=$2 group_name=$3"
