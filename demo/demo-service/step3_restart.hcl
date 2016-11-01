job "demo-service" {
  datacenters = [
    "dc1"
  ]
  type = "service"
  group "group" {
    restart {
      interval = "5m" # interval of failures
      attempts = 2    # restarts allowed in interval
      delay = "5s"   # delay before restarting
      mode = "delay"  # delay or fail
    }
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