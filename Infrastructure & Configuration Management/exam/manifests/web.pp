$packages = [ 'httpd', 'php', 'php-mysqlnd', 'git' ]

package { $packages: }

vcsrepo { '/code':
  ensure => present,
  provider => git,
  source => 'https://github.com/shekeriev/do2-app-pack.git',
}

file_line { 'hosts-web':
  ensure => present,
  path => '/etc/hosts',
  line => '192.168.99.101  web.server  web',
  match => '^192.168.99.101',
}

file_line { 'hosts-db':
  ensure => present,
  path => '/etc/hosts',
  line => '192.168.99.102  db.server  db',
  match => '^192.168.99.102',
}

file { '/etc/httpd/conf.d/vhost-app1.conf':
  ensure => present,
  content => 'Listen 8081
<VirtualHost *:8081>
    DocumentRoot "/var/www/app1"
</VirtualHost>',
}

file { '/etc/httpd/conf.d/vhost-app2.conf':
  ensure => present,
  content => 'Listen 8082
<VirtualHost *:8082>
    DocumentRoot "/var/www/app2"
</VirtualHost>',
}

file { '/var/www/app1':
  ensure => 'directory',
  recurse => true,
  source => '/code/app4/web',
}

file { '/var/www/app2':
  ensure => 'directory',
  recurse => true,
  source => '/code/app2/web',
}

class firewall {
  firewalld_port { 'Open port 8081/tcp':
    ensure   => 'present',
    zone     => 'public',
    port     => 8081,
    protocol => 'tcp',
  }

  firewalld_port { 'Open port 8082/tcp':
    ensure   => 'present',
    zone     => 'public',
    port     => 8082,
    protocol => 'tcp',
  }
}

class { selinux:
 mode => 'disabled',
}

service { httpd:
  ensure => running,
  enable => true,
}
