class dopostgresql (

  # class arguments
  # ---------------
  # setup defaults
  
  $version = '9.2',
  $port = 5432,

  # by default do not expose ports
  $firewall = false,

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

