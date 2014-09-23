class samba (
  $workgroup         = 'DOMAIN',
  $valid_users       = '@DOMAIN\"Domain Admins"',
  $server_string     = 'Example Samba Server',
  $interfaces        = 'eth0 lo',
  $security          = 'ads',
  $sharename         = 'samba-share',
  $sharecomment      = 'testshare',
  $path              = '/data/test',
  $read_only         = false,
  $target_ou         = "Computers",
  $nsswitch          = true,
  $winbindaccount    = 'DomainAdmin',
  $winbindpassword   = 'DomainAdminPass',
  $winbindrealm      = 'DOMAIN',
  $load_printers     = 'no',
  $disable_spoolss   = 'yes',
){

  class {'samba::server':
    workgroup       => $workgroup,
    server_string   => $server_string,
    interfaces      => $interfaces,
    security        => $security,
    load_printers   => $load_printers,
    disable_spoolss => $disable_spoolss,
  }

  samba::server::share {$sharename:
    comment           => $sharecomment,
    path              => $path,
    read_only         => $read_only,
    valid_users       => $valid_users,
  }

  if $security == 'ads' {
    class { 'samba::server::ads':
      winbind_acct    => $winbindaccount,
      winbind_pass    => $winbindpassword,
      realm           => $winbindrealm,
      nsswitch        => $nsswitch,
      target_ou       => $target_ou
    }
  }
}