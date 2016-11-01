# Nomad Demo

## Software versions
- VirtualBox: **5.0.26r108824**
- Vagrant: **1.8.5**
- Ansible: **2.1.1.0**
- Maven: **3.3.9**
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

## Snapshots
Save snapshot of initial state
```sh
vagrant snapshot save init
```
Restore snapshot of initial state
```sh
vagrant halt
vagrant snapshot restore init
```

## Start http server
**ONLINE**
```sh
npm install http-server
```
**OFFLINE**
```sh
./node_modules/.bin/http-server .
```

## Start service
**ONLINE**
```sh
mvn clean install -f demo/demo-service
```
**OFFLINE**
```sh
mvn clean install -f demo/demo-service
nomad run demo/demo-service_step1.hcl
nomad run demo/demo-service_step2_services.hcl
nomad run demo/demo-service_step3_restart.hcl
```

## Start batch
**ONLINE**
```sh
mvn clean install -f demo/demo-batch
```
**OFFLINE**
```sh
mvn clean install -f demo/demo-batch
nomad run demo/demo-batch.hcl
```

## Start storage
**ONLINE**
```sh
docker pull elasticsearch:2.3.5
docker save elasticsearch:2.3.5 > downloads/elasticsearch-2.3.5.tar
docker pull elasticsearch:2.4.1
docker save elasticsearch:2.4.1 > downloads/elasticsearch-2.4.1.tar
```
**OFFLINE**
```sh
nomad run demo/demo-storage_step1.hcl
nomad run demo/demo-storage_step2_scaleup.hcl
nomad run demo/demo-storage_step3_rolling_update.hcl
nomad run demo/demo-storage_step4_blue_green.hcl
```

## Start Nomad UI

[Nomad UI](http://192.168.99.1:3000)

**ONLINE**
```sh
docker pull iverberk/nomad-ui:v0.2.1
docker save iverberk/nomad-ui:v0.2.1 > downloads/nomad-ui-v0.2.1.tar
```
**OFFLINE**
```sh
docker run -e NOMAD_ADDR=http://192.168.99.100:4646 -p 3000:3000 iverberk/nomad-ui:v0.2.1
```

## Start Fabio

[Fabio UI](http://192.168.99.1:9998/)

[Load Balancer](http://192.168.99.1:9999/hello)

**ONLINE**
```sh
docker pull magiconair/fabio:1.3.4-go1.7.3
docker save magiconair/fabio:1.3.4-go1.7.3 > downloads/fabio-1.3.4-go1.7.3.tar
```
**OFFLINE**
```sh
docker run -e registry_consul_addr=192.168.99.100:8500 -e registry_consul_register_addr=192.168.99.1:9998 -p 9999:9999 -p 9998:9998 magiconair/fabio:1.3.4-go1.7.3
```
