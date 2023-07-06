# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

ENV['VAGRANT_SERVER_URL'] = 'https://vagrant.elab.pro'

Vagrant.configure("2") do |config|

  config.vm.box = "debian/bullseye64"
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 50000, host: 50000
  config.vm.network "public_network" , bridge: "wlp0s20f3", auto_config: true

  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 7
  end

  config.vm.provision "ansible" do |ansible|
#    ansible.verbose = "v"
    ansible.playbook = "provisioning/main.yml"
    ansible.verbose = true
  end

  config.vm.provision :shell do |shell|
    shell.inline = "/home/vagrant/jenkins_init_pass.sh"
  end
end
