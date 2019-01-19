#!/bin/bash

############
# Run once #
############
if [ ! -f ~/.run_ceph_once ]
then

    ##############
    # Setup ceph #
    ##############
    sudo apt-get install -y ceph-deploy

    mkdir /vagrant/data/ceph
    cd /vagrant/data/ceph

    ceph-deploy new vm1
    ceph-deploy install vm1 vm2 vm3
    ceph-deploy mon create-initial
    ceph-deploy admin vm1 vm2 vm3
    ceph-deploy mgr create vm1

    ceph-deploy osd create --data /dev/sdc vm1
    ceph-deploy osd create --data /dev/sdc vm2
    ceph-deploy osd create --data /dev/sdc vm3

    ceph-deploy mds create vm1 vm2 vm3
    ceph-deploy mon create vm1 vm2 vm3
    ceph-deploy mgr create vm1 vm2 vm3

    sudo ceph osd pool create cephfs_data 64
    sudo ceph osd pool create cephfs_metadata 64
    sudo ceph fs new cephfs cephfs_metadata cephfs_data

    grep "key = " ceph.client.admin.keyring | awk '{print $3}' > admin.secret

    sudo mkdir /cephfs
    sudo chown vagrant:vagrant /cephfs
    sudo mount -t ceph vm1:6789:/ /cephfs -o name=admin,secretfile=admin.secret

    ssh vm2 'sudo mkdir /cephfs'
    ssh vm2 'sudo chown vagrant:vagrant /cephfs'
    ssh vm2 'cd /vagrant/data/ceph && sudo mount -t ceph vm1:6789:/ /cephfs -o name=admin,secretfile=admin.secret'

    ssh vm3 'sudo mkdir /cephfs'
    ssh vm3 'sudo chown vagrant:vagrant /cephfs'
    ssh vm3 'cd /vagrant/data/ceph && sudo mount -t ceph vm1:6789:/ /cephfs -o name=admin,secretfile=admin.secret'

    touch /cephfs/ceph_test

    ####################
    # Create lock file #
    ####################
    touch ~/.run_ceph_once

fi

