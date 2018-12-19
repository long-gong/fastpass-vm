# [fastpass](http://fastpass.mit.edu/) on Ubuntu 16.04 via Vagrant

The repo contains a simple [vagrantfile](./Vagrantfile) together with a [setup](./setup.sh) bash script to create a UBUNTU 16.04 virtual machine which installs all the prerequsites for [Fastpass](http://fastpass.mit.edu/): A Centeralized "Zero-Queue" Datacenter Network. It will compile certain components of fastpass.


## Prerequsites

+ [Vagrant](https://www.vagrantup.com/)
+ [VirtualBox](https://www.vagrantup.com/) or any other virtualization softwares supported by Vagrant.

## Setup

```bash
git clone https://github.com/long-gong/fastpass-vm.git
cd fastpass-vm
vagrant up
```

Note that it will take you tens of minutes to setup the VM.

