job "demo-router" {
  datacenters = [
    "dc1"
  ]
  type = "service" # service or batch
  group "group" {
    task "app" {
      driver = "docker"
      artifact {
        source = "http://192.168.99.1:8080/downloads/fabio-1.3.4-go1.7.3.tar"
      }
      config {
        image = "magiconair/fabio:1.3.4-go1.7.3"
        load = [
          "fabio-1.3.4-go1.7.3.tar"
        ]
        port_map {
          http = 9999
          admin = 9998
        }
      }
      env {
        registry_consul_addr = "${NOMAD_IP_http}:8500"
        registry_consul_register_enabled = false
        proxy_strategy = "rr" # "rr" for round-robin or "rnd" for pseudo-random
      }
      service {
        name = "demo-router"
        port = "admin"
        check {
          type = "http"
          path = "/health"
          interval = "10s"
          timeout = "2s"
        }
      }
      constraint {
        attribute = "${node.unique.name}"
        value = "nomad1"
      }
      resources {
        cpu = 50
        memory = 200
        disk = 1000
        network {
          mbits = 10
          port "http" {
            static = 80
          }
          port "admin" {
            static = 9998
          }
        }
      }
    }
  }
}