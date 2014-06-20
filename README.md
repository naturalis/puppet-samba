# Puppet Samba Module

Module for provisioning Samba, Modified with additional features and foreman compatibility by Naturalis.

Tested on Ubuntu 12.04

## Installation

Clone this repo to your Puppet modules directory or into the foreman environment
    git clone git://github.com/naturalis/puppet-samba.git samba

Make sure the $path exists and has 777 permissions. ( /data/test in this example )

The fileserver name that will be added to the active directory is named after the hostname of the system. Make sure the hostname does not exceed 15 characters, the script will fail if it is longer. 

Depending on replication time of domain controllers it may take some time before the checks in the scripts are working fine.
wbinfo -u will give an empty result and the configure_active_directory script returns : ERROR: return user list from AD is empty
Wait some time and try again, the problem should dissapear. 

## Usage

Adjust the defaults in init.pp or override them using puppet or The Foreman

```
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
  $winbindrealm      = 'DOMAIN.LOCAL',
```

## Result

Working samba file server with Active Directory integration. 

## License

This module is released under the MIT license  [http://www.opensource.org/licenses/MIT](http://www.opensource.org/licenses/MIT)


