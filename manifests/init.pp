# == Class: rails
#
# Class to install Ruby on Rails.
#
# === Authors
#
# Włodzimierz Gajda <gajdaw@gajdaw.pl>
#
# === Copyright
#
# Copyright 2015 Włodzimierz Gajda
#

class rails {

    #
    # Handle platforms
    #
    if !(
        ($::operatingsystem == 'Ubuntu' and $::lsbdistrelease == '14.04') or
        ($::operatingsystem == 'Ubuntu' and $::lsbdistrelease == '12.04')
    ) {
        fail('Platform not supported.')
    }

    if defined(Package['libsqlite3-dev']) == false {
        package { 'libsqlite3-dev': ensure => present }
    }

    if defined(Package['gem']) == false {
        package { 'gem': ensure => present }
    }

    exec { 'rails::gem-update':
        command => 'gem update --system',
        path    => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
        require => [Package['gem']]
    }

    exec { 'rails::rails':
        command => 'gem install rails',
        timeout => 6000,
        path    => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
        require => [Exec['rails::gem-update']]
    }

    exec { 'rails::gem-sqlite3':
        command => 'gem install sqlite3 -v "1.3.9"',
        path    => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
        require => [Package['gem', 'libsqlite3-dev'], Exec['rails::rails']]
    }

}
