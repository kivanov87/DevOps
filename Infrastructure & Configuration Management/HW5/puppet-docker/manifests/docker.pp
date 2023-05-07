$packages = [ 'docker-ce', 'docker-ce-cli', 'containerd.io' ]

package { $packages: }

docker::run { 'nginx':
  image   => 'nginx',
  ports   => ['80:80'],
  require => [Class['docker'], File['/etc/nginx/conf.d/nginx.conf']],
}

file { '/etc/nginx/conf.d/nginx.conf':
  content => template('nginx/nginx.conf.erb'),
  notify  => Service['docker'],
}

service { 'docker':
  ensure     => running,
  enable     => true,
  subscribe  => File['/etc/sysconfig/docker'],
}
class { 'firewall': }

firewall { '000 accept 80/tcp':
  action   => 'accept',
  dport    => 80,
  proto    => 'tcp',
}

selboolean { 'Apache SELinux':
  name       => 'httpd_can_network_connect', 
  persistent => true, 
  provider   => getsetsebool, 
  value      => on, 
}
