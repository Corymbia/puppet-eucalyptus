class eucalyptus::clc {
  Class[eucalyptus] -> Class[eucalyptus::clc]
  package { 'eucalyptus-cloud':
    ensure => present,
  }
  service { 'eucalyptus-cloud':
    ensure => running,
    enable => true,
    require => Package['eucalyptus-cloud'],
	subscribe => Eucalyptus_config['VNET_MODE']
  }
  @@file { 'nc-cert':
    path => '/var/lib/eucalyptus/nc-cert.pem',
	content => "$eucakey_nc-cert.pem",
  }
  @@file { 'nc-pk':
    path => '/var/lib/eucalyptus/nc-pk.pem',
	content => "$eucakey_nc-pk.pem",
	require => File['nc-cert'],
  }
  @@file { 'cc-cert':
    path => '/var/lib/eucalyptus/cc-cert.pem',
	content => "$eucakey_cc-cert.pem",
  }
  Eucalyptus_config <||>
}
