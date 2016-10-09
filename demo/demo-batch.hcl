job "demo-batch" {
  region = "global"
  datacenters = [
    "dc1"
  ]
  type = "batch"
  periodic {
    #enabled = false
    # every 10 seconds
    cron = "*/10 * * * * * *"
    prohibit_overlap = true
  }
  task "app" {
    driver = "java"
    artifact {
      source = "http://192.168.99.1:8080/nomad-app/target/nomad-app-1.0-batch.jar"
    }
    config {
      jar_path = "local/nomad-app-1.0-batch.jar"
      jvm_options = [
        "-Xmx${NOMAD_MEMORY_LIMIT}m",
        "-Dnode.name=${node.unique.name}"
      ]
    }
    resources {
      cpu = 50
      memory = 32
      disk = 1000
      network {
        mbits = 100
      }
    }
  }
}