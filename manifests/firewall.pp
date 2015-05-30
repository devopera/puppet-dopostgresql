class dopostgresql::firewall (

  # class arguments
  # ---------------
  # setup defaults

  $port = undef, 

  # end of class arguments
  # ----------------------
  # begin class

) {

  if ($port != undef) {
    @docommon::fireport { "00${port} PostgreSQL service":
      protocol => 'tcp',
      port     => $port,
    }
  }

}

