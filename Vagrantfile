# -*- mode: ruby -*-
# vi: set ft=ruby :

NUM_DEVWORKERS = (ENV['DEVWORKERS'] || 0).to_i

Vagrant.configure("2") do |config|
  #config.vm.box = "opensuse/Tumbleweed.x86_64"
  #config.vm.box = "opensuse/Leap-15.2.x86_64"
  config.vm.box = "fedora/34-cloud-base"
  config.vm.provider "libvirt" do |provider|
    provider.cpus = 4
    provider.memory = "12288"
  end
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true
  config.ssh.forward_agent = true
  config.vm.define "devmaster" do |node|
    node.vm.hostname = "devmaster"
    node.vm.synced_folder ".", "/vagrant", type: "sshfs"
    node.vm.synced_folder "~/dev", "/home/vagrant/dev", type: "sshfs"
    node.vm.provision "shell", inline: "/vagrant/.provisioners/provision.sh system"
    node.vm.provision "shell", inline: "/vagrant/.provisioners/provision.sh user", privileged: false
    node.trigger.before :destroy do |t|
      t.info = "Checking for no dirty dotfiles"
      t.run_remote = {inline: "bash -c 'cd /home/vagrant/.dotfiles && git diff --quiet && git diff --cached --quiet || exit 1'"}
      t.on_error = :halt
    end
  end
  (1..NUM_DEVWORKERS).each do |i|
    config.vm.define "devworker#{i}" do |node|
      node.vm.hostname = "devworker#{i}"
    end
  end
end
