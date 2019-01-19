# Cluster with Ceph/Docker-Swarm
Vagrant setup with 3 servers with ceph storage and a docker swarm.

## Requirements
* [Vagrant](https://www.vagrantup.com/)
* [Virtualbox](https://www.virtualbox.org/)
* Linux or macOS host (recommended)
* Or Windows host (a little bit different)

## Concept
* Cluster of 3 server
  * vm1 = 192.168.100.10
  * vm2 = 192.168.100.11
  * vm3 = 192.168.100.12
* Ceph storage
* Docker swarm

## Information
Based on and more information:
* [Ceph, Preflight](http://docs.ceph.com/docs/master/start/quick-start-preflight/)
* [Ceph, Storage Cluster Quick Start](http://docs.ceph.com/docs/master/start/quick-ceph-deploy/)
* [Ceph, Filesystem Quick Start](http://docs.ceph.com/docs/master/start/quick-cephfs/)
* [Docker-Swarm](https://docs.docker.com/engine/swarm/swarm-tutorial/create-swarm/)

## Setup
Setup the cluster:
```
git clone https://github.com/scope-li/vagrant_ceph_docker.git
cd vagrant_ceph_docker
make
```
Recreate the cluster:
```
make rebuild
```
Remove the cluster:
```
make clean
```

## Server
Login `vm1` server:
```
vagrant ssh vm1
```
Login `vm2` server:
```
vagrant ssh vm1
```
Login `vm3` server:
```
vagrant ssh vm1
```

##  Ceph
Check ceph system:
```
sudo ceph -s
```

##  Docker swarm
List nodes in docker swarm:
```
docker node ls
```