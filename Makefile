install:
	sudo apt-get install -y qemu libvirt-bin ebtables dnsmasq
	sudo apt-get install -y libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev
	vagrant plugin install vagrant-libvirt

deploy: cloud-init/testing-cidata.iso
	vagrant up --provider=libvirt

provision:
	vagrant provision

destroy:
	vagrant destroy
