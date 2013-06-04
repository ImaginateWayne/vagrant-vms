node 'precise32' {

  exec { "apt-get-update":
    command => "apt-get update",
    path    => "/usr/bin/:/bin/",
  }

  class { 'mysql::server':
    config_hash => {
        'root_password' => 'foo',
        'bind_address' => '0.0.0.0'
    },
    require => Exec['apt-get-update'],
  }

  class { 'mysql::java':}

  database_user { 'admin@10.0.2.2':
    password_hash => mysql_password('foo'),
    require => Class['mysql::server'],
  }
  database_grant { 'admin@10.0.2.2':
    privileges => ['all'],
    require => Class['mysql::server'],
  }
}