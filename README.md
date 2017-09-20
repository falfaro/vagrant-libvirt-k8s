# Vagrant

This project requires the "experimental" libvirt provider
for Vagrant in order to provision virtual machines in KVM:
https://github.com/vagrant-libvirt/vagrant-libvirt

First, install the vagrant-libvirt plugin:

```
sudo apt-get install qemu libvirt-bin ebtables dnsmasq
sudo apt-get install libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev
vagrant plugin install vagrant-libvirt
```

Next, prepare a Vagrant box from Ubuntu 16.04 Xenial:

```
cd vagrant-libvirt
wget https://cloud-images.ubuntu.com/releases/16.04/release/ubuntu-16.04-server-cloudimg-amd64-disk1.img
qemu-img resize ubuntu-16.04-server-cloudimg-amd64-disk1.img 32GB
./create_box.sh ubuntu-16.04-server-cloudimg-amd64-disk1.img
vagrant box add ubuntu-16.04-server-cloudimg-amd64-disk1.box --name xenial
```

To spawn a Kubernetes cluster:

```
vagrant up --provider=libvirt
```
