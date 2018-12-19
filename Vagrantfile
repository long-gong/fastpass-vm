# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    name = "netsys-xenial64"
    config.vm.hostname = "#{name}"

    # Box
    config.vm.box = "ubuntu/xenial64"

    config.vm.provider "virtualbox" do |vb|
        vb.gui = false
        vb.name = "#{name}"

        vb.memory = 4096
        vb.cpus = 4
        # Configure VirtualBox to enable passthrough of SSE 4.1 and SSE 4.2
        # instructions, according to this:
        # https://www.virtualbox.org/manual/ch09.html#sse412passthrough
        # This step is fundamental otherwise DPDK won't build.
        # It is possible to verify in the guest OS that these changes took effect
        # by running `cat /proc/cpuinfo` and checking that `sse4_1` and `sse4_2`
        # are listed among the CPU flags
        vb.customize ["setextradata", :id, "VBoxInternal/CPUM/SSE4.1", "1"]
        vb.customize ["setextradata", :id, "VBoxInternal/CPUM/SSE4.2", "1"]
    end

    # Network
    config.vm.network "forwarded_port", guest: 2333, host: 3333
    config.ssh.forward_agent = true
    config.ssh.forward_x11 = true
    config.vm.network "private_network", ip: "10.0.2.19"

    # Setup
    config.vm.provision "shell", path: "setup.sh"
end