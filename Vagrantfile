# Define basic
BOX = "ubuntu/bionic64"
BOX_VERSION = "20190112.0.0"
RAM = 1024
CPU = 2

# Define hosts
hosts=[
  {
    :hostname => "vm3",
    :ip => "192.168.100.12",
    :disk1 => "./disks/disk-3-1.vmdk",
    :disk2 => "./disks/disk-3-2.vmdk"
  },
  {
    :hostname => "vm2",
    :ip => "192.168.100.11",
    :disk1 => "./disks/disk-2-1.vmdk",
    :disk2 => "./disks/disk-2-2.vmdk"
  },
  {
    :hostname => "vm1",
    :ip => "192.168.100.10",
    :disk1 => "./disks/disk-1-1.vmdk",
    :disk2 => "./disks/disk-1-2.vmdk"
  }
]

Vagrant.configure(2) do |config|

  hosts.each do |host|

    config.vm.define host[:hostname] do |node|

      node.ssh.forward_agent = true

      node.vm.box = BOX
      node.vm.box_version = BOX_VERSION
      node.vm.hostname = host[:hostname]
      node.vm.network "private_network", ip: host[:ip]

      node.vm.provider "virtualbox" do |vb|

        vb.name = host[:hostname]
        vb.customize ["modifyvm", :id, "--memory", RAM]
        vb.customize ["modifyvm", :id, "--cpus", CPU]

        cephDisk = './data/disks/' + host[:hostname] + '-ceph.vmdk'
        if not File.exists?(cephDisk)
          vb.customize ['createhd', '--filename', cephDisk, '--variant', 'Fixed', '--size', 5 * 1024]
        end
        vb.customize ['storageattach', :id,  '--storagectl', 'SCSI', '--port', 2, '--device', 0, '--type', 'hdd', '--medium', cephDisk]

      end

      node.vm.provision :shell, :path => "./bootstraps/privileged/once.sh"
      node.vm.provision :shell, :path => "./bootstraps/privileged/always.sh", run: "always"
      node.vm.provision :shell, :privileged => false, :path => "./bootstraps/unprivileged/ssh.sh"

      if host[:hostname] == "vm1"
        node.vm.provision :shell, :privileged => false, :path => "./bootstraps/unprivileged/ceph.sh"
        node.vm.provision :shell, :privileged => false, :path => "./bootstraps/unprivileged/docker.sh"
      end

    end

  end

end