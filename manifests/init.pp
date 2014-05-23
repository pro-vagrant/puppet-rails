class rails {

  package { "gem":
    ensure => present
#    require => [Class['ruby']]
  }

  exec { 'rails::gem-update':
    command => "gem update --system",
    path    => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
    require => [Package['gem']]
  }

  exec { 'rails::rails':
    command => "gem install rails",
    timeout => 6000,
    path    => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
    require => [Exec['rails::gem-update']]
  }

  exec { 'rails::gem-sqlite3':
    command => "gem install sqlite3 -v '1.3.9'",
    path    => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
    require => [Exec['rails::gem-update', 'rails::rails']]
  }

}
