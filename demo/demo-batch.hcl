job "demo-batch" {
  region = "global"
  datacenters = [
    "dc1"
  ]
  type = "batch"
  periodic {
    cron = "*/10 * * * * * *"
    prohibit_overlap = true
  }
  task "app" {
    driver = "java"
    artifact {
      source = "http://192.168.99.1:8080/demo/demo-batch/target/demo-batch-1.0-exec.jar"
    }
    config {
      jar_path = "local/demo-batch-1.0-exec.jar"
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