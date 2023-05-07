$packages = [ 'httpd', 'php', 'php-mysqlnd' ]

package { $packages: }

service { httpd:
  ensure => running,
  enable => true,
}

file { '/var/www/html/index.php':
  ensure => present,
  source => "/vagrant/app/index.php",
}

file { '/var/www/html/bulgaria-map.png':
  ensure => present,
  source => "/vagrant/app/bulgaria-map.png",
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
