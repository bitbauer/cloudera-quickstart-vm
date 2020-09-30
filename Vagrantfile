# -*- mode: ruby -*-
# vi: set ft=ruby :

# The most common configuration options are documented and commented below.
# For a complete reference, please see the online documentation at
# https://docs.vagrantup.com.
VAGRANTFILE_VERSION = "2"
Vagrant.require_version ">= 1.8.1"

load './tests/vagranthelper/load_configuration.rb'
load './tests/vagranthelper/require_plugins.rb'

Vagrant.configure(VAGRANTFILE_VERSION) do |config|
  # Check for required vagrant plugins
  require_plugins config, %w(vagrant-hostmanager vagrant-vbguest vagrant-cachier vagrant-serverspec)

  # Load basic configuration of this VM
  configuration = load_configuration('localdev', './tests/configuration.yml')
  vm_name = configuration["hostname"]
  vm_fqdn = vm_name + "." + configuration["domain"]
  config.ssh.forward_agent = true

  config.vm.define vm_name, primary: true do |guest|

    # Basic configuration for VirtualBox
    guest.vm.provider "virtualbox" do |vb|
      vb.name=vm_name
      vb.cpus=2
      vb.memory=10240
      #vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
	  vb.customize ["modifyvm", :id, "--vram", "256"]
    end
    guest.vm.box = "quickstart/cdh"
	guest.vm.box_version = "5.15.2"
    guest.vm.network "private_network", type: "dhcp"
    guest.vm.network "forwarded_port", guest: configuration["port"], host: configuration["port"]

    # Define VM name and resolving its name to IP address
    guest.vm.hostname = vm_fqdn
    guest.hostmanager.enabled = true
    guest.hostmanager.manage_host = true
    guest.hostmanager.aliases = [vm_fqdn]
    guest.hostmanager.ip_resolver = proc do |vm, _|
      `VBoxManage guestproperty get #{vm.id} "/VirtualBox/GuestInfo/Net/1/V4/IP"`.split()[1] if vm.id
    end

    # Initialize and trigger provision testing using ServerSpec
    guest.vm.provision "test",
          type: :serverspec,
          preserve_order: true,
          pattern: "tests/serverspec/*_spec.rb"
  end
end
