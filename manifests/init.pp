class dopostgresql (

  # class arguments
  # ---------------
  # setup defaults
  
  $version = '9.2',

  # end of class arguments
  # ----------------------
  # begin class

) {

  class { 'postgresql::globals':
    manage_package_repo => true,
    version             => $version,
  }->
  class { 'postgresql::server':
  }

}

