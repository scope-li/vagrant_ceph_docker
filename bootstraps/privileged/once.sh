#!/bin/bash

#################
# Update system #
#################
apt-get update
apt-get upgrade -y

#################
# Install tools #
#################
apt-get install -y docker-compose htop ceph ceph-deploy ntp openssh-server

#############
# Setup ntp #
#############
systemctl start ntp
systemctl enable ntp

##################
# Disable apache #
##################
service apache2 stop
update-rc.d apache2 disable

############
# Run once #
############
if [ ! -f ~/.run_once ]
then

    ####################
    # Add ceph storage #
    ####################
    wget -q -O- 'https://download.ceph.com/keys/release.asc' | apt-key add -
    echo deb https://download.ceph.com/debian-mimic/ $(lsb_release -sc) main | tee /etc/apt/sources.list.d/ceph.list
    apt-get update -y

    ###############
    # Docker jobs #
    ###############
    usermod -a -G docker vagrant

    #####################
    # Add hosts entries #
    #####################
    echo "192.168.100.10 vm1" >> /etc/hosts
    echo "192.168.100.11 vm2" >> /etc/hosts
    echo "192.168.100.12 vm3" >> /etc/hosts

    ###################
    # Format seh disk #
    ###################
    mkfs.ext4 /dev/sdc

    ####################
    # Create lock file #
    ####################
    touch ~/.run_once

fi

