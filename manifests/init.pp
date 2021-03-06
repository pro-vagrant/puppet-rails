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

    $gems = [
        'rails',
        'rspec',
        'cucumber',
        'cucumber-rails',
        'database_cleaner',
        'capybara',
        'nokogiri',
        { 'rspec-rails' => '~> 3.0' },
        { 'mysql2'      => '0.3.20' },
        { 'sqlite3'     => '1.3.9' }
    ]

    rails::gems { $gems: }

}
