#!/bin/bash

echo "Installing microk8s..."

sudo swapoff -a
sudo snap install microk8s --classic
# add user to microk8s sudoers group
sudo usermod -a -G microk8s ubuntu

group=microk8s

if [ $(id -gn) != $group ]; then
  exec sg $group "$0 $*"
fi

sudo snap alias microk8s.helm helm > /dev/null
sudo snap alias microk8s.helm3 helm3 > /dev/null

# add kubect as alias
sudo snap alias microk8s.kubectl kubectl > /dev/null
sudo snap alias microk8s.kubectl k > /dev/null

microk8s enable dns > /dev/null
microk8s enable hostpath-storage > /dev/null
microk8s enable dashboard > /dev/null
microk8s enable helm > /dev/null
microk8s enable ingress > /dev/null
