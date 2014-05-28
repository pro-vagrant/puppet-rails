class rails {

  if defined(Package['libsqlite3-dev']) == false {
    package { 'libsqlite3-dev': ensure => present }
  }

  if defined(Package['gem']) == false {
    package { 'gem': ensure => present }
  }

  exec { 'rails::apt-get-update':
    command => "apt-get update -y",
    path    => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin'
  }

  exec { 'rails::gem-update':
    command => "gem update --system",
    path    => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
    require => [Exec['rails::apt-get-update'], Package['gem']]
  }

  exec { 'rails::gem-sqlite3':
    #command => "gem install --no-document sqlite3 -v '1.3.9'",
    command => "gem install sqlite3 -v '1.3.9'",
    path    => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
    require => [Package['gem', 'libsqlite3-dev'], Exec['rails::gem-update']]
  }

  exec { 'rails::rails':
    command => "gem install rails",
    timeout => 6000,
    path    => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
    require => [Exec['rails::gem-update', 'rails::gem-sqlite3']]
  }

}
