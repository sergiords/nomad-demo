job "demo-service" {
  region = "global"
  datacenters = [
    "dc1"
  ]
  type = "service"
  update {
    stagger = "5s"
    max_parallel = 1
  }
  group "group" {
    count = 1
    task "app" {
      driver = "java"
      artifact {
        source = "http://192.168.99.1:8080/nomad-app/target/nomad-app-1.0-service.jar"
      }
      config {
        jar_path = "local/nomad-app-1.0-service.jar"
        args = []
        jvm_options = [
          "-Xmx${NOMAD_MEMORY_LIMIT}m",
          "-Dnode.name=${node.unique.name}"
        ]
      }
      service {
        name = "demo-service"
        port = "http"
        check {
          type = "http"
          path = "/hello?from=consul"
          interval = "10s"
          timeout = "2s"
        }
      }
      resources {
        cpu = 50
        memory = 128
        disk = 1000
        network {
          mbits = 100
          port "http" {
          }
        }
      }
    }
  }
}