# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = 'bento/ubuntu-16.04'
  config.vm.box_version = '2.2.9'
  config.vm.box_check_update = false

  config.vm.provider 'virtualbox' do |vb|
    vb.gui = true
    vb.cpus = '1'
    vb.memory = '512'
  end

  server_ip = '192.168.99.100'

  nodes = {
      :nomad0 => {:node_ip => "#{server_ip}"},
      :nomad1 => {:node_ip => '192.168.99.101'},
      :nomad2 => {:node_ip => '192.168.99.102'},
      :nomad3 => {:node_ip => '192.168.99.103'}
  }

  nodes.each do |node_name, node_entry|

    config.vm.define "#{node_name}" do |node|

      node.vm.hostname = "#{node_name}"
      node.vm.network 'private_network', ip: "#{node_entry[:node_ip]}"
      node.vm.provider 'virtualbox' do |vb|
        vb.name = "#{node_name}"
      end

    end

  end

  config.vm.provision 'ansible' do |ansible|
    ansible.sudo = true
    ansible.playbook = 'ansible/playbook.yml'
    ansible.host_vars = nodes
    ansible.extra_vars = {:server_ip => "#{server_ip}"}
  end

end
