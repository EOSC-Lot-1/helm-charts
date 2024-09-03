# vim: set syntax=hcl:

target "rsyslog" {
  context = "./docker/rsyslog/"
  dockerfile = "./Dockerfile"
  contexts = {
  }
  args = {
  }
  tags = [
    "docker-registry.eosc.athenarc.gr/rsyslog:latest"
  ]
}

target "logrotate" {
  context = "./docker/logrotate/"
  dockerfile = "./Dockerfile"
  contexts = {
  }
  args = {
  }
  tags = [
    "docker-registry.eosc.athenarc.gr/logrotate:latest"
  ]
}
