job "demo-storage" {
  datacenters = [
    "dc1"
  ]
  type = "service"
  group "group" {
    task "app" {
      driver = "docker"
      artifact {
        source = "http://192.168.99.1:8080/downloads/elasticsearch-2.3.5.tar"
      }
      config {
        image = "elasticsearch:2.3.5"
        load = [
          "elasticsearch-2.3.5.tar"
        ]
        port_map {
          http = 9200
          tcp = 9300
        }
      }
      resources {
        cpu = 50
        memory = 128
        disk = 150
        network {
          mbits = 10
          port "http" {
          }
          port "tcp" {
          }
        }
      }
    }
  }
}