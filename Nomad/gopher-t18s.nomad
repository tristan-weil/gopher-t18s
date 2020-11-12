job "gopher-t18s" {
  datacenters = [
    "bi-sbg"]

  group "backend" {
    count = 1

    shutdown_delay = "20s"

    reschedule {
      attempts = 5
      interval = "1h"
      delay = "30s"
      delay_function = "constant"
      unlimited = false
    }

    restart {
      attempts = 3
      interval = "5m"
      delay = "30s"
      mode = "fail"
    }

    update {
      max_parallel     = 1
      canary = 1
      auto_revert      = true
      auto_promote     = false
      health_check     = "checks"
      min_healthy_time = "10s"
      healthy_deadline = "2m"
      progress_deadline = "10m"
      stagger = "15s"
    }

    migrate {
      max_parallel     = 1
      health_check     = "checks"
      min_healthy_time = "10s"
      healthy_deadline = "2m"
    }

    constraint {
      attribute = "${meta.client_type}"
      value = "node"
    }

    constraint {
      distinct_hosts = true
    }

    task "docker-image" {
      driver = "docker"

      shutdown_delay = "20s"

      env {
          TTSERVER_LISTENER_ADDRESS="0.0.0.0:${NOMAD_PORT_tcp}"
      }

      config {
        image = "ghcr.io/tristan-weil/gopher-t18s:v1.0.2"
      }

      resources {
        network {
          mode = "host"
          port "tcp" {}
        }
      }

      service {
        name = "gopher-t18s"
        port = "tcp"

        tags = [
          "traefik.enable=true",
          "traefik.tcp.routers.gophersecure-t18s.rule=HostSNI(`*`)",
          "traefik.tcp.routers.gophersecure-t18s.entrypoints=gopher,gophersecure",
          "traefik.tcp.routers.gophersecure-t18s.service=gopher-t18s@consulcatalog",
          "traefik.tcp.routers.gophersecure-t18s.tls=true",
          "traefik.tcp.routers.gophersecure-t18s.tls.certResolver=letsencrypt",
          "traefik.tcp.routers.gophersecure-t18s.tls.domains[0].main=gopher.t18s.fr",

          "traefik.tcp.routers.gopher-t18s.rule=HostSNI(`*`)",
          "traefik.tcp.routers.gopher-t18s.entrypoints=gopher,gophersecure",
          "traefik.tcp.routers.gopher-t18s.service=gopher-t18s@consulcatalog",

          "traefik.tcp.services.gopher-t18s.loadbalancer.server.port=${NOMAD_HOST_PORT_tcp}",
        ]

        check {
          type = "tcp"
          port = "tcp"
          interval = "15s"
          timeout = "2s"
        }
      }
    }
  }
}
