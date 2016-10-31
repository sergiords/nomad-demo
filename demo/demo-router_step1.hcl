job "demo-router" {
  datacenters = [
    "dc1"
  ]
  type = "service"
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
        registry_consul_register_addr = "${NOMAD_IP_admin}:${NOMAD_HOST_PORT_admin}"
        registry_consul_register_name = "demo-router"
      }
      resources {
        network {
          mbits = 10
          port "http" {
          }
          port "admin" {
          }
        }
      }
    }
  }
}