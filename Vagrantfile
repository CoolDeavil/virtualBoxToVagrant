# -*- mode: ruby -*-
# vi: set ft=ruby :
# Base Vagrantfile
Vagrant.configure("2") do |config|
    config.vm.box = "baseUbuntuServer20"
    config.vm.hostname = "zencoding"

    config.vm.provider "virtualbox" do |v|
        v.memory = 4096
        v.cpus = 4
    end

    config.vm.network "private_network", ip: "192.168.18.19"
    # Enable access for webpack dev server
    config.vm.network :forwarded_port, guest: 3030, host: 3000, auto_correct: true
    config.vm.network :forwarded_port, guest: 3031, host: 3001, auto_correct: true
    # Allow symlinks on the shared folder (on windows must open shell as admin)
    config.vm.synced_folder ".", "/var/www/html/application",
        :mount_options => ["dmode=777", "fmode=777"],
        SharedFoldersEnableSymlinksCreate: true
end

