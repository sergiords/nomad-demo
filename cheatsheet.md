# Cheat Sheet


## Nomad

### Connect remotely to nomad
```
export NOMAD_ADDR="http://192.168.99.100:4646"
```
### Start agent
```
nomad agent -dev                  # client and server
nomad agent -config server.hcl    # server only
nomad agent -config client.hcl    # client only
```
### Inspect clients
```
nomad node-status
```
### Inspect servers
```
nomad server-members
nomad server-members -detailed
```
### Plan, run and stop job
```
nomad plan    job.hcl
nomad run     job.hcl
nomad stop    job
```
### Get job status
```
nomad status          job
nomad status -evals   job
```
### Get evaluation status
```
nomad eval-status <evalid>
```
### Get allocation status
```
nomad alloc-status <allocid>
```
### Get allocation logs
```
nomad logs <allocid>
nomad logs -f <allocid>
nomad logs -stderr <allocid>
nomad logs -f -stderr <allocid>
```
### Start service
```sh
sudo systemctl restart nomad
```
### check logs
```sh
journalctl -u nomad
```


## Consul

### Connect remotely to consul
```
export CONSUL_RPC_ADDR="192.168.99.100:8400"
```
### Start agent
```
consul agent -config-dir /etc/consul.d/
```
### start service
```sh
sudo systemctl restart consul
```
## check logs
```sh
journalctl -u consul
```


## System

### show ports
```sh
ss -ltu
```
### show interfaces
```sh
ip link show
```
