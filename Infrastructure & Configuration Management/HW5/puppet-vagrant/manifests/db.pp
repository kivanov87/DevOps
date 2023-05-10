class { '::mysql::server':
  package_name     => 'mariadb-server',
  package_ensure   => '1:10.3.21+maria~xenial',
  service_name     => 'mysqld',
  root_password           => '12345',
  remove_default_accounts => true,
  restart                 => true,
  override_options => {
    mysqld => { 
      'bind-address' => '0.0.0.0'
      'log-error' => '/var/log/mysql/mariadb.log',
      'pid-file'  => '/var/run/mysqld/mysqld.pid',
    },  
    mysqld_safe => {
      'log-error' => '/var/log/mysql/mariadb.log',
    },
  },
}

Apt::Source['mariadb'] ~>
Class['apt::update'] ->
Class['mysql::server']

mysql::db { 'bulgaria':
  user        => 'web_user',
  password    => 'Password1',
  dbname      => 'bulgaria',
  host        => '%',
  sql         => ['/vagrant/app/db.sql'],
  enforce_sql => true,
}

class { 'firewall': }

firewall { '000 accept 3306/tcp':
  action   => 'accept',
  dport    => 3306,
  proto    => 'tcp',
  provider => 'iptables',
}
