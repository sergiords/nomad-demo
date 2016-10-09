# Nomad Demo Steps

## Start http server
**ONLINE**
```sh
npm install http-server
```
**OFFLINE**
```sh
./node_modules/.bin/http-server .
```

## Start haproxy
**ONLINE**
```sh
docker pull haproxy:1.6.9 -alpine
```
**OFFLINE**
```sh
consul-template -consul 192.168.99.100:8500 -template="demo/haproxy.cfg.ctmpl:/tmp/haproxy.cfg:docker kill -s HUP haproxy"
consul-template -consul 192.168.99.100:8500 -template="demo/haproxy.cfg.ctmpl:/tmp/haproxy.cfg"
docker run --rm --name haproxy -p 8000:80 -p 9000:9200 -v /tmp/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro haproxy:1.6.9-alpine
```

## Start service
**ONLINE**
```sh
mvn clean install
```
**OFFLINE**
```sh
mvn clean install
nomad run demo/demo-service.hcl
```

## Start batch
**ONLINE**
```sh
mvn clean install
```
**OFFLINE**
```sh
mvn clean install
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
nomad run demo/demo-storage.hcl
```