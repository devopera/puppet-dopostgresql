class dopostgresql (

  # class arguments
  # ---------------
  # setup defaults
  
  $version = '9.2',
  $port = 5432,

  # by default do not expose ports
  $firewall = false,

  # by default, only accept connections from localhost
  $listen_addresses = 'localhost',

  # end of class arguments
  # ----------------------
  # begin class

) {

  if ($firewall) {
    class { 'dopostgresql::firewall' :
      port => $port,
    }
    @domotd::register { "Postgres(${port})" : }
  } else {
    @domotd::register { "Postgres[${port}]" : }
  }

  class { 'postgresql::globals':
    manage_package_repo => true,
    version             => $version,
  }
  class { 'postgresql::server':
    listen_addresses => $listen_addresses,
    require => [Class['postgresql::globals']],
  }
  class { 'postgresql::lib::devel':
    require => [Class['postgresql::globals']],
  }

  if (str2bool($::selinux)) {
    docommon::seport { "tcp/${port}":
      port => $port,
      seltype => 'postgresql_port_t',
    }
  }
}

