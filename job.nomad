job "${job_name}" {
  datacenters = ${datacenters}
  region      = "${region}"
  namespace   = "${namespace}"
  type        = "service"

  %{ for constraint in constraints }
  constraint {
    attribute = "${constraint.attribute}"
    value     = "${constraint.value}"
    operator  = "${constraint.operator}"
  }
  %{ endfor }

  group "${job_name}" {
    network {
      %{ for port, info in ports }
      port "${port}" {
        static = ${info.static}
        to     = ${info.to}
      }
      %{ endfor }
      mode = "${network_mode}"
    }

    %{ for port, tags in service_tags}
    service {
      port = "${port}"
      tags = ${jsonencode(tags)}
    }
    %{ endfor }

    task "${job_name}" {
      driver = "docker"
      config {
        image = "${image}"
        args = ${args}
        ports = ${jsonencode(
          [for port, _ in ports : "${port}"]
        )}
        volumes = ${volumes}
        network_mode = "${docker_network_mode}"

        auth {
          username = "${docker_username}"
          password = "${docker_password}"
        }
      }

      env {
        %{ for key, value in env}
        ${key} = "${value}"
        %{ endfor }
      }

      resources {
        cpu    = "${cpu}"
        memory = "${memory}"
      }

      %{ for dest, values in template_files }
      template {
        destination   = "${dest}"
        change_mode   = ${jsonencode(lookup(values, "mode", "restart"))}
        change_signal = ${jsonencode(lookup(values, "signal", ""))}
        data = <<EOF
${values.data}
        EOF
      }
      %{ endfor }
    }
  }
}
