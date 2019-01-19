#!/bin/bash

############
# Run once #
############
if [ ! -f ~/.run_ssh_once ]
then

    #############
    # Setup ssh #
    #############
    if [ ! -f /vagrant/data/ssh/id_rsa.pub ]; then
        mkdir /vagrant/data/ssh
        ssh-keygen -t rsa -N '' -f /vagrant/data/ssh/id_rsa -C "ceph-vagrant"
    fi

    cp /vagrant/data/ssh/id_rsa ~/.ssh/id_rsa
    cp /vagrant/data/ssh/id_rsa.pub ~/.ssh/id_rsa.pub
    cat /vagrant/data/ssh/id_rsa.pub >>~/.ssh/authorized_keys

    echo 'Host *'                     >~/.ssh/config
    echo '  User vagrant'             >>~/.ssh/config
    echo '  StrictHostKeyChecking no' >>~/.ssh/config

    ####################
    # Create lock file #
    ####################
    touch ~/.run_ssh_once

fi

