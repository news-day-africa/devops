# -*- mode: ruby -*-
# vi: set ft=ruby :

$installAnsibleRoles = <<-SHELL
    apt-get install -y ansible
    ansible-galaxy install tersmitten.wordpress
SHELL

$installBuildEssentials = <<-SHELL
    apt-get update
    apt-get install -y build-essential libssl-dev git
SHELL


Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.hostname = "wordpress.devbox"

  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.network "forwarded_port", guest: 80, host: 8080, autocorrect: true
  config.vm.synced_folder "../webstarterkit-spike/dist", "/var/www/html/wp-content/themes/the-mast-theme"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "2048"
  end

  # configure wordpress installation
  config.vm.provision "shell", inline: $installAnsibleRoles
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "provision/site.yml"
  end

  # # configure nodejs workspace
  config.vm.provision "shell", inline: $installBuildEssentials
  config.vm.provision "shell", path: "provision/install_node.sh", privileged: false
end
