job "demo-service" {
  datacenters = [
    "dc1"
  ]
  type = "service"
  update {
    stagger = "10s" # delay between instances update
    max_parallel = 1
  }
  group "group" {
    count = 5
    task "app" {
      driver = "java"
      artifact {
        source = "http://192.168.99.1:8080/demo/demo-service/target/demo-service-2.0-exec.jar"
      }
      config {
        jar_path = "local/demo-service-2.0-exec.jar"
        jvm_options = [
          "-Xmx${NOMAD_MEMORY_LIMIT}m",
          "-Dnode.name=${node.unique.name}"
        ]
      }
      service {
        name = "demo-service"
        port = "http"
        tags = ["urlprefix-/hello"]
        check {
          type = "http"
          path = "/hello?from=consul"
          interval = "10s"
          timeout = "2s"
        }
      }
      resources {
        cpu = 50
        memory = 200
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