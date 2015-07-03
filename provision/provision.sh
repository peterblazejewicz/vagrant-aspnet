#!/bin/bash
#
# provision.sh
#
# This file is specified in Vagrantfile and is loaded by Vagrant as the primary
# provisioning script whenever the commands `vagrant up`, `vagrant provision`,
# or `vagrant reload` are used.
apt-get update
# install tools documented by Hackaton starter kit
sudo apt-get install build-essential
# Install other build tools
apt-get install -y make g++ git curl vim libcairo2-dev libav-tools nfs-common portmap
# Install Node
apt-get update
curl -sL https://deb.nodesource.com/setup | sudo bash -
sudo apt-get install -y nodejs
sudo npm update -g npm
sudo npm install -g nodemon
