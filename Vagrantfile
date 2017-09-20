# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.provider :libvirt do |domain|
    domain.memory = 2048
    domain.cpus = 2
    domain.nested = true
    domain.volume_cache = 'writeback'
    # cloud-init via ISO CD-ROM
    domain.storage :file, :device => :cdrom, :bus => :ide, :type => :raw, :path => "/home/falfaro/k8s/cloud-init/testing-cidata.iso"
  end

  # Install Python 2.7
  config.vm.provision :shell, path: "bootstrap.sh"

  # Use :ansible or :ansible_local to
  # select the provisioner of your choice
  config.vm.provision :ansible do |ansible|
    ansible.playbook = "kubespray/cluster.yml"
    ansible.sudo = true
    ansible.limit = "all"
    ansible.host_key_checking = false
    #ansible.raw_arguments = ["--forks=#{$num_instances}"]
    #ansible.host_vars = {
    #  "default" => {
    #    "ansible_python_interpreter" => "/usr/bin/pytho3"
    #    }
    #  }
    #ansible.tags = ['download']
    ansible.groups = {
      "etcd" => ["kubemaster[1:3]"],
      "kube-master" => ["kubemaster[1:3]"],
      "kube-node" => ["kubeworker[1:2]"],
      "k8s-cluster:children" => ["kube-master", "kube-node"],
     }
  end

  config.ssh.username = "ubuntu"
  config.ssh.insert_key = FALSE
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  # Defaults to Ubuntu 16.04 (Xenial)
  config.vm.box = "xenial"

  # Kubemasters
  (1..3).each do |i|
    hostname = "kubemaster#{i}"
    config.vm.define hostname do |node|
      node.vm.hostname = hostname
    end
  end

  # Kubenodes
  (1..2).each do |i|
    hostname = "kubeworker#{i}"
    config.vm.define hostname do |node|
      node.vm.hostname = hostname
    end
  end
end
