#!/bin/bash

#######################################
# From VirtualBox To Vagrant Box
#######################################

# Create VM using VirtualBox ex: name  phpDevServer
# set network to bridged
# disable usb
# disable sound
# set number cpus (4) and memory (4096 MB)
# boot with the os iso
# ubuntu-20.04-live-server-amd64.iso
# On Install set the all credentials to vagrant (computer, name, user, password)


# Enter the vm
ssh vagrant@ 00.00.00 #(on login get ip from ipv6)
# Update Ubuntu Server then Prepare the vm to recognize vagrant

##########################
# Vagrant specific
##########################

echo "vagrant"|passwd --stdin vagrant
# Set editor to Vim
sudo update-alternatives --config editor

visudo
# add this line to allow sudo with no password
# vagrant  ALL=(ALL)  NOPASSWD: ALL" >> /etc/sudoers.d/vagrant

##########################
# Installing vagrant insecure keys
##########################
mkdir -pm 700 /home/vagrant/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh

#################################################
# Update guest Additions to the latest (6.1.16)
##################################################
sudo apt-get install linux-headers-$(uname -r) build-essential dkms -y
wget http://download.virtualbox.org/virtualbox/6.1.16/VBoxGuestAdditions_6.1.16.iso
sudo mkdir /media/VBoxGuestAdditions
sudo mount -o loop,ro VBoxGuestAdditions_6.1.16.iso /media/VBoxGuestAdditions
sudo sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
rm VBoxGuestAdditions_6.1.16.iso
sudo umount /media/VBoxGuestAdditions
sudo rmdir /media/VBoxGuestAdditions

########################################
#  Clean the VirtualBox
########################################
sudo apt-get clean && sudo apt-get autoremove -y
sudo dd if=/dev/zero of=/EMPTY bs=1M
sudo rm -f /EMPTY
cat /dev/null > ~/.bash_history && history -c && exit
# Important STOP the VM and reset the network to NAT

########################################
#  Package and add to Vagrant boxes
########################################
vagrant package --base VM-Name --output ~/virtualBoxes/baseUbuntoServer20.box
cd ~/virtualBoxes
vagrant add ~/virtualBoxes/baseUbuntoServer20.box baseUbuntoServer20
vagrant box list

# Use this clean installation as the Lamp Server;
mkdir phpVMachine
cd phpVMachine
# Add the base Vagrantfile
vagrant up
vagrant ssh

#################################################
#  Clean, Package and Add tho vagrant boxes
#################################################
sudo apt-get clean && sudo apt-get autoremove -y
#Resolves the problems with npm on long path names on shared folders
mkdir ~/node_modules
ln -sl ~/node_modules /var/www/html/application
cd /var/www/html/application
# Shared folder of the project from config.vm.synced_folder
# Project Folder
ls -la

# Install baseLAMP
sudo dd if=/dev/zero of=/EMPTY bs=1M
sudo rm -f /EMPTY
cat /dev/null > ~/.bash_history && history -c && exit
vagrant box package --output phpVirtualDev.box

# End of tasks
vagrant box list

# Box ready for upload! :-)
# sha1 required for the vagrant Cloud upload!
sha1sum phpVirtualDev.box

# Copy the Vagrantfile to the project root and!
vagrant up!
vagrant add phpVirtualDev.box phpVirtualDev
cd /var/www/html/application
# Shared folder of the project (Apache root )
ls -la

# GitHub
# Create a new repository: virtualBoxToVagrant
git init
git add .
git commit -m 'starting commit'
git remote add origin https://github.com/CoolDeavil/virtualBoxToVagrant.git
git branch -M main
git push -u origin main
