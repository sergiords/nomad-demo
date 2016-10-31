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
Save snapshot for step0
```sh
vagrant snapshot save step0
```
Restore snapshot for step0
```sh
vagrant halt
vagrant snapshot restore step0
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

## Start httpd
**ONLINE**
```sh
docker pull httpd:2.4.23-alpine
```
**OFFLINE**
```sh
docker run --rm --name httpd -p 80:80 -v "$PWD":/usr/local/apache2/htdocs/ httpd:2.4.23-alpine
```

## Start haproxy
**ONLINE**
```sh
docker pull haproxy:1.6.9-alpine
```
**OFFLINE**
```sh
consul-template -consul 192.168.99.100:8500 -template="demo/haproxy.cfg.ctmpl:/tmp/haproxy.cfg:docker kill -s HUP haproxy"
consul-template -consul 192.168.99.100:8500 -template="demo/haproxy.cfg.ctmpl:/tmp/haproxy.cfg"
docker run --rm --name haproxy -p 8000:8000 -p 9000:9000 -v /tmp/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro haproxy:1.6.9-alpine
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
docker pull iverberk/nomad-ui
```
**OFFLINE**
```sh
docker run -e NOMAD_ADDR=http://192.168.99.100:4646 -p 3000:3000 iverberk/nomad-ui
```

## Start Fabio

[Fabio UI](http://192.168.99.1:9998/)

[Load Balancer](http://192.168.99.1:9999/hello)

**ONLINE**
```sh
docker pull magiconair/fabio
```
**OFFLINE**
```sh
docker run -e registry_consul_addr=192.168.99.100:8500 -e registry_consul_register_addr=192.168.99.1:9998 -p 9999:9999 -p 9998:9998 magiconair/fabio
```
