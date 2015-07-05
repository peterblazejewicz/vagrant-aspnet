#!/bin/bash
#
# provision.sh
#
# This file is specified in Vagrantfile and is loaded by Vagrant as the primary
# provisioning script whenever the commands `vagrant up`, `vagrant provision`,
# MIXED implementation sources
# ENV
MONO_VERSION=4.0.1
LIBUV_VERSION=1.4.2
DNX_VERSION=1.0.0-beta5
DNX_USER_HOME=~/.dnx
# RUN
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb http://download.mono-project.com/repo/debian wheezy main" \
  | sudo tee /etc/apt/sources.list.d/mono-xamarin.list
sudo apt-get update
sudo apt-get install -y mono-complete
sudo apt-get install -y automake \
  libtool \
  curl \
  unzip
curl -sSL https://github.com/libuv/libuv/archive/v$LIBUV_VERSION.tar.gz \
  | sudo tar zxfv - -C /usr/local/src
cd /usr/local/src/libuv-$LIBUV_VERSION
sudo sh autogen.sh
sudo ./configure
sudo make
sudo make install
sudo rm -rf /usr/local/src/libuv-$LIBUV_VERSION && cd ~/
sudo ldconfig
cd /home/vagrant
curl -sSL https://raw.githubusercontent.com/aspnet/Home/dev/dnvminstall.sh \
  | DNX_BRANCH=dev sh
source $DNX_USER_HOME/dnvm/dnvm.sh \
  && dnvm install $DNX_VERSION -a default \
  && dnvm alias default | xargs -i ln -s $DNX_USER_HOME/runtimes/{} $DNX_USER_HOME/runtimes/default
export PATH=$PATH:$DNX_USER_HOME/runtimes/default/bin
# git (will be used by Bower)
sudo apt-get update
sudo apt-get install -y git-core
# node
sudo apt-get update
sudo apt-get install -y python-software-properties \
  python \
  g++
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install nodejs
# Grunt/Gulp/Bower
sudo npm install -g bower grunt-cli gulp
