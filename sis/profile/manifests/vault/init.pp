class profile::vault::init (
  $my_bin_dir = lookup('vault::bin_dir'),
  $my_config_dir = lookup('vault::config_dir'),
  $my_install_method = lookup('vault::install_method'),
  $my_service_name = lookup('vault::service_name'),
  $my_service_enable = lookup('vault::service_enable'),
  $my_service_ensure = lookup('vault::service_ensure'),
  $my_download_dir = lookup('vault::download_dir'),
  $my_download_filename = lookup('vault::download_filename'),
  $my_version = lookup('vault::version'),
  $my_default_lease_ttl = lookup('vault::default_lease_ttl'),
  $my_config_hash = lookup('vault::config::config_hash'),
  $my_unit_file = lookup('vault::systemd::unit_file'),

) {
   if $facts['os']['name'] == 'CentOS' {
     class {'vault':
       bin_dir => "${my_bin_dir}",
       config_dir => "${my_config_dir}",
       install_method => "${my_install_method}",
       manage_config_file => false,
       manage_service_file => false,
       service_name => "${$my_service_enable}",
       service_ensure => "${my_service_ensure}",
       download_dir => "${my_download_dir}",
       download_filename => "${$my_download_filename}",
       version => "${$my_version}",
       disable_mlock => true,
  }

       file {"/etc/vault/config.hcl":
         path    => "/etc/vault/config.hcl",
         ensure  => 'file',
         mode    => '0644',
         group   => $group,
         owner   => $user,
         source  => 'puppet:///modules/profile/config.hcl',
      }

       systemd::unit_file { 'vault.service':
         content => file("profile/vault.service"),
         enable  => true,
         active  => true,
       }

     
    }
  }
 


      
