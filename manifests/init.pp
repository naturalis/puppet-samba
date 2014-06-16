class samba (
  $workgroup         = 'DOMAIN',
  $server_string     = 'Example Samba Server',
  $interfaces        = 'eth0 lo',
  $security          = 'ads',
  $sharename         = 'samba-share',
  $sharecomment      = 'testshare',
  $path              = '/data/test',
  $browsable         = true,
  $writable          = true,
  $create_mask       = 0770,
  $directory_mask    = 0770,
  $valid_users       = '@DOMAIN\"Domain Admins"',
  $nsswitch          = true,
  $target_ou         = "Computers",
  $winbindaccount    = 'DomainAdmin',
  $winbindpassword   = 'DomainAdminPass',
  $winbindrealm      = 'DOMAIN',
){

  class {'samba::server':
    workgroup       => $workgroup,
    server_string   => $server_string,
    interfaces      => $interfaces,
    security        => $security
  }

  samba::server::share {$sharename:
    comment           => $sharecomment,
    path              => $path,
    browsable         => $browsable,
    writable          => $writable,
    create_mask       => $create_mask,
    directory_mask    => $directory_mask,
    valid_users       => $valid_users
  }

  if $security == 'ads' {
    class { 'samba::server::ads':
      winbind_acct    => $winbindaccount,
      winbind_pass    => $winbindpassword,
      realm           => $winbindrealm,
      nsswitch        => $nsswitch,
      target_ou       => $targetOU
    }
  }
}