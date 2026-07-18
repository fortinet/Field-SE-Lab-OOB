#! /bin/bash

# Enable verbose execution of this script
set -v

echo ##########   start     #############
echo ##### Ubuntu GNS3 Install ##########

### The following steps can be found here 
###[GNS3 Ubuntu Install](https://docs.gns3.com/docs/getting-started/installation/linux)
### When prompted whether non-root users should be allowed to use wireshark and ubridge, select **‘Yes’** both times

sudo add-apt-repository -y ppa:gns3/ppa

sudo apt update -y 

sudo apt install gns3-server -y

sudo dpkg --add-architecture i386

sudo apt update -y

sudo apt install gns3-iou -y

sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository -y \
"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(. /etc/os-release && echo $VERSION_CODENAME) stable"

sudo apt update -y

sudo apt install docker-ce -y

sudo usermod -aG ubridge,libvirt,kvm,docker $(whoami)

echo ##########   Start   ###########
echo #### Create gns3.service #######
sudo chmod 755 gns3.service
sudo chown root gns3.service
sudo chown :root gns3.service
sudo mv gns3.service /etc/systemd/system/

sudo systemctl start gns3.service
sudo systemctl enable gns3.service
echo ##########   End     ############
echo #### Create gns3.service ########

echo #################################
echo ####                         ####
echo ####    reboot required      ####
echo ####                         ####
echo #################################
echo ####### rebooting now    ########
echo #################################

sudo sleep 5
sudo reboot now
