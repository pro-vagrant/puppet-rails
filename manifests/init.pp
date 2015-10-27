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

    # validate_platform() function comes from
    # puppet module gajdaw/diverse_functions
    #
    #     https://forge.puppetlabs.com/gajdaw/diverse_functions
    #
    if !validate_platform($module_name) {
        fail("Platform not supported in module '${module_name}'.")
    }

    include stdlib

    $deps = [
        'gem',
        'libsqlite3-dev',
        'libmysqlclient-dev',
    ]
    ensure_packages($deps)

    exec { 'rails::rails':
        command => 'gem install rails',
        timeout => 6000,
        path    => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
        require => Package['gem']
    }

    exec { 'rails::rspec':
        command => 'gem install rspec',
        path    => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
        require => [Package['gem'], Exec['rails::rails']]
    }

    exec { 'rails::cucumber':
        command => 'gem install cucumber',
        path    => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
        require => [Package['gem'], Exec['rails::rails']]
    }

    exec { 'rails::gem-sqlite3':
        command => 'gem install sqlite3 -v "1.3.9"',
        path    => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
        require => [Package['gem', 'libsqlite3-dev'], Exec['rails::rails']]
    }

    exec { 'rails::cucumber-rails':
        command => 'gem install cucumber-rails',
        path    => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
        require => [Package['gem'], Exec['rails::rails']]
    }

    exec { 'rails::database_cleaner':
        command => 'gem install database_cleaner',
        path    => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
        require => [Package['gem'], Exec['rails::rails']]
    }

    exec { 'rails::capybara':
        command => 'gem install capybara',
        path    => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
        require => [Package['gem'], Exec['rails::rails']]
    }

    exec { 'rails::nokogiri':
        command => 'gem install nokogiri',
        path    => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
        require => [Package['gem'], Exec['rails::rails']]
    }

    exec { 'rails::rspec-rails':
        command => 'gem install rspec-rails -v "~> 3.0"',
        path    => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
        require => [Package['gem'], Exec['rails::rails']]
    }

    exec { 'rails::mysql2':
        command => 'gem install mysql2 -v "~> 0.3.20"',
        path    => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
        require => [Package['gem', 'libmysqlclient-dev'], Exec['rails::rails']]
    }


}
