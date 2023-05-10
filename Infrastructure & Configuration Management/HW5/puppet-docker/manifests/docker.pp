class { 'docker': }

docker::run { 'nginx':
  image            => 'nginx:latest',
  detach           => true,
  ports            => ['80:80'],
}

class { 'firewall': }

firewall { '000 accept 80/tcp':
  dport    => 80,
  proto    => 'tcp',
  action   => 'accept',
}
