# Nomad Demo

## Software versions
- VirtualBox: **5.0.26r108824**
- Vagrant: **1.8.5**
- Consul: **0.7.0**
- Consul-template: **0.16.0**
- Nomad: **0.4.1**

## Start nodes with vagrant

All nodes at once
```sh
vagrant up                    # start all nodes
```

One node at a time
```sh
vagrant up nomad0             # start server
vagrant up nomad1             # start client 1
vagrant up nomad2             # start client 2
vagrant up nomad3             # start client 3
```
