#!/bin/bash
sudo apt-get install qemu-utils
sudo modprobe nbd

if [ ! -f ubuntu-16.04-server-cloudimg-amd64-disk1.img ]; then
  wget 'https://cloud-images.ubuntu.com/releases/16.04/release/ubuntu-16.04-server-cloudimg-amd64-disk1.img'
  qemu-img resize ubuntu-16.04-server-cloudimg-amd64-disk1.img 32G
fi

sudo qemu-nbd --connect=/dev/nbd0 ubuntu-16.04-server-cloudimg-amd64-disk1.img

sudo mkdir -p /mnt/ubuntu

sudo mount /dev/nbd0p1 /mnt/ubuntu

sudo mount -t proc proc /mnt/ubuntu/proc/
sudo mkdir /mnt/ubuntu/run/resolvconf
sudo cp /etc/resolv.conf //mnt/ubuntu/run/resolvconf/

sudo chroot /mnt/ubuntu apt-get update
sudo chroot /mnt/ubuntu apt-get -y --purge remove update-manager-core
sudo chroot /mnt/ubuntu apt-get -y --purge remove python3-update-manager

sudo chroot /mnt/ubuntu apt-get install python -y

sudo umount /mnt/ubuntu/proc

sync

sudo umount /mnt/ubuntu
sudo qemu-nbd --disconnect /dev/nbd0

