#! /bin/bash

variable1="Timezone"
#   api_token_secret
#   api_host
#   storage
#   storage_name
#   ubuntu_template_name
#   ubuntu_template_vmid

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
  echo "Example 1:  $0   US/Eastern 
  echo "Example 2:  $0   US/Central 
  echo "Example 3:  $0   US/Mountain 
  echo "Example 4:  $0   US/Pacific 
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

# sed -i "/proxmox_api_token_secret/c\  proxmox_api_token_secret = $1"         global.yml 
# sed -i "/proxmox_api_host/c\  proxmox_api_host = $1"                         global.yml
# sed -i "/proxmox_storage/c\  proxmox_storage = $1"                           global.yml
# sed -i "/proxmox_storage_name/c\  proxmox_storage_name = $1"                 global.yml
# sed -i "/proxmox_ubuntu_template_name/c\  proxmox_ubuntu_template_name = $1" global.yml
# sed -i "/proxmox_ubuntu_template_vmid/c\  proxmox_ubuntu_template_vmid = $1" global.yml

### Enable verbose execution of script ###
set -v

sed -i "/fortinet_timezone:/c\  fortinet_timezone: \"$1\"" global.yml
