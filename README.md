# FHNW Sysad Project 

## Assignment
To create a fileserver on a linux based OS. the project must run on SwitchEngine and keep in mind that not the end product is impotent, the destination  and way there is what matters. So dose should be well documented

## Goals

* desisting of the fileserver with comprehensible reason/explanation
* Installation an configuration of the fileserver. again with comprehensible reason/explanation
* configuration of the SwitchEngine to make accessible

## Switcheng
We created to instances on switcheng for the project. the first one for the nextcloud file server. the second one for backups. both VMs are running on Debian because of stability and our familiarity with the os

### basic setup
installation of docker

adding the public docker repo key to the keyring, in order that apt/user can verify that packet is officially from docker

```bash
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

adding the docker repo to apt source list

```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```
fetching the new source list and installing docker community editions
* docker-ce = docker engine/daemon
* docker-ce-cli = command line interface for docker
* containerd.io = OCI container run time
* docker-compose-plugin = added docker compose functionality to the cli

```bash
sudo apt update && sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin
```