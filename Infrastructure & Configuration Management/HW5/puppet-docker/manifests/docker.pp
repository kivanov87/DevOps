class { 'docker':
  package_source_location => 'https://yum.dockerproject.org/repo/main/centos/7',
  package_release         => '17.05.0.ce-1.el7.centos',
}

docker::run { 'nginx':
  image   => 'nginx',
  ports   => ['80:80'],
  require => Class['docker'],
}
