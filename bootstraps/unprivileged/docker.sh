#!/bin/bash

############
# Run once #
############
if [ ! -f ~/.run_docker_once ]
then

    ################
    # Setup docker #
    ################
    mkdir /vagrant/data/docker

    sudo docker swarm init --listen-addr 192.168.100.10:2377 --advertise-addr 192.168.100.10:2377
    sudo docker swarm join-token -q worker > /vagrant/data/docker/worker_token

    ssh vm2 'sudo docker swarm join --token $(cat /vagrant/data/docker/worker_token) 192.168.100.10:2377'
    ssh vm3 'sudo docker swarm join --token $(cat /vagrant/data/docker/worker_token) 192.168.100.10:2377'

    ####################
    # Create lock file #
    ####################
    touch ~/.run_docker_once

fi

