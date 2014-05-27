class rails {

  if defined(Package['libsqlite3-dev']) == false {
    package { 'libsqlite3-dev': ensure => present }
  }

  if defined(Package['gem']) == false {
    package { 'gem': ensure => present }
  }

  exec { 'rails::gem-sqlite3':
    command => "gem install --no-ri --no-rdoc sqlite3 -v '1.3.9'",
    path    => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
    require => [Package['gem', 'libsqlite3-dev']]
  }

  exec { 'rails::gem-update':
    command => "gem update --system",
    path    => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
    require => [Package['gem'], Exec['rails::gem-sqlite3']]
  }

  exec { 'rails::rails':
    command => "gem install --no-ri --no-rdoc rails",
    timeout => 6000,
    path    => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
    require => [Exec['rails::gem-update']]
  }

}
