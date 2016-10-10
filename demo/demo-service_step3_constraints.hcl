job "demo-service" {
  datacenters = [
    "dc1"
  ]
  type = "service"
  group "group" {
    task "app" {
      driver = "java"
      artifact {
        source = "http://192.168.99.1:8080/demo/demo-service/target/demo-service-1.0-exec.jar"
      }
      config {
        jar_path = "local/demo-service-1.0-exec.jar"
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
      constraint {
        attribute = "${node.unique.name}"
        value = "nomad1"
      }
      logs {
        max_files = 5
        max_file_size = 10
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