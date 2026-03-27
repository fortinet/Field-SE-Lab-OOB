#! /bin/bash

variable1="Subnet"

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
  echo "Example 1:  $0  <external subnet to SE Lab>" 
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

sed -i "s/172.16.3/$1/g"   generate-dynamic-netplan.sh 
sed -i "s/172.16.3/$1/g"   c_data/coredns/conf/zones/db.fortinet.internal
sed -i "s/172.16.3/$1/g"   c_data/coredns/conf/zones/db.home.internal
sed -i "s/172.16.3/$1/g"   c_data/homepage/config/bookmarks.yaml
sed -i "s/172.16.3/$1/g"   c_data/homepage/config/services.yaml
sed -i "s/172\.16\.3/$1/g" c_data/guacamole/dump.sql
sed -i "s/172.16.3/$1/g"   automation/ansible/vars/all-hosts.yml

