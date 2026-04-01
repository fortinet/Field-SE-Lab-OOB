#! /bin/bash

# Enable verbose execution of this script
set -v

echo ##########   start     ############
echo #####Ubuntu OOB Install##########


echo ##########   start     ############
echo ###### Application Install ########
sudo apt update      -y
sudo apt upgrade     -y
sudo apt autoremove  -y
sudo apt install     -y xorriso 
sudo apt install     -y mkisofs
sudo apt install     -y whois
sudo apt-get install -y cloud-image-utils
sudo apt install     -y tftpd-hpa
echo ##########     end     ############
echo ###### Application Install ########


echo ##########   start     ############
echo ######## Python3 Install ##########
sudo apt install -y python3-pip
sudo apt install -y python3-proxmoxer
sudo apt install -y python3-requests
echo ##########     end     ############
echo ######## Python3 Install ##########

echo ##########   start     ############
echo ######## Ansible Install ##########
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible
#### "general" and "proxmox" should already be installed
sudo ansible-galaxy collection install community.general
sudo ansible-galaxy collection install community.proxmox
sudo ansible-galaxy collection install fortinet.fortiflexvm
sudo ansible-galaxy collection install fortinet.fortios
sudo ansible-galaxy collection install fortinet.fortimanager
sudo ansible-galaxy collection install fortinet.fortianalyzer
ansible-galaxy collection install fortinet.fortiflexvm
ansible-galaxy collection install fortinet.fortianalyzer
echo ##########     end     ############
echo ######## Ansible Install ##########


echo ########### start ################
echo # Change hostname and Wallpaper ##
gsettings set org.gnome.desktop.background picture-uri file:////home/$USER/Pictures/OOB-GUI-Mgt.png
gsettings set org.gnome.desktop.background picture-uri-dark file:////home/$USER/Pictures/OOB-GUI-Mgt.png
gsettings set org.gnome.desktop.background picture-options 'stretched'
sudo hostnamectl set-hostname Ubuntu-OOB
echo ###########  end  ################
echo # Change hostname and Wallpaper ##


echo ##########   start     ############
echo ####### enable ip_forwad  #########
## https://askubuntu.com/questions/776929/how-to-edit-my-etc-sysctl-conf-file
echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf
echo ##########    end      ############
echo ####### enable ip_forwad  #########


echo ##########   start     ############
echo ###### Set IP Addresses #########
sudo chmod 774 generate-dynamic-netplan.sh
sudo chown root generate-dynamic-netplan.sh
sudo chown :root generate-dynamic-netplan.sh
sudo mv generate-dynamic-netplan.sh /usr/local/bin/


sudo chmod 644 dynamic-netplan.service
sudo chown root dynamic-netplan.service
sudo chown :root dynamic-netplan.service
sudo mv dynamic-netplan.service /etc/systemd/system/
sudo systemctl enable dynamic-netplan.service
sudo systemctl start dynamic-netplan.service
echo ##########   end     ############
echo ###### Set IP Addresses #########


echo ##########   start     ############
echo ######## resolved.conf   ##########
echo ## see => https://di-marco.net/blog/it/2024-05-09-Intall_and_configure_coredns/
sudo chmod 644 resolved.conf
sudo chown root resolved.conf
sudo chown :root resolved.conf
sudo mv resolved.conf /etc/systemd
sudo systemctl restart systemd-resolved
echo ###########   end      ############
echo ######## resolved.conf   ##########


echo ########### start ################
echo ####### Install Docker  ##########
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common --assume-yes
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt-cache policy docker-ce
sudo apt install docker-ce --assume-yes
echo ####### Install Docker  ##########
echo ##########    end     ############


echo ########### start ################
echo ## Execute Docker without sudo ###
sudo usermod -aG docker ${USER}
echo ## Execute Docker without sudo ###
echo ##########    end     ############


echo ########### start ################
echo ## container/config/script dirs ##

mkdir ../automation
cp -rf ./automation/* ../automation/
rm -rf ./automation/
sudo chmod -R 775 ../automation
sudo find ../automation/ -type f -iname "*.txt"       -exec chmod 664 {} \;
sudo find ../automation/ -type f -iname "*.cfg"       -exec chmod 664 {} \;
sudo find ../automation/ -type f -iname "*.yml"       -exec chmod 664 {} \;
sudo find ../automation/ -type f -iname "*.conf"      -exec chmod 664 {} \;
sudo find ../automation/ -type f -iname "*.user_data" -exec chmod 664 {} \;
sudo find ../automation/ -type f -iname "*.lic"       -exec chmod 664 {} \;

mkdir ../c_data
cp -rf ./c_data/* ../c_data/
rm -rf ./c_data/
echo ## container/config/script dirs ##
echo ##########     end     ############

echo ##########   start     ############
echo #JavaScript/Package Manager Install
cd /home/fortinet/c_data/foaas/
sudo apt install -y nodejs npm
sudo npm install    express
sudo npm install
cd /home/fortinet/Downloads/
echo ##########     end     ############
echo #JavaScript/Package Manager Install


echo ###### start last check   ########
echo ######application install#########
sudo apt update --assume-yes
sudo apt upgrade --assume-yes
sudo apt autoremove --assume-yes
echo ###### end last check   ##########
echo ######application install#########


echo ##########    end     ############
echo #####Ubuntu Base Install##########
rm OOB_Install.sh
sudo rm README.md
sudo rm update_subnet.sh
sudo rm .gitignore
sudo rm -r .git

echo #################################
echo ####                         ####
echo ####    reboot required      ####
echo ####  run OOB_Containers.sh   ###
echo ####     after reboot        ####
echo ####                         ####
echo #################################
echo ####### rebooting now    ########
echo #################################

sudo sleep 5
sudo reboot now