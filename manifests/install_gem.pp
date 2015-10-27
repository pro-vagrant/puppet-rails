define rails::install_gem {

    include stdlib

    if is_string($name){

        exec { "rails::install_gem::${name}":
            command => "gem install ${name}",
            timeout => 6000,
            path    => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
            require => Package['gem']
        }

    } elsif is_hash($name) and has_key($name, 'gem') and has_key($name, 'ver') {

        exec { "rails::install_gem::${name['gem']}-${name['ver']}":
            command => "gem install ${name['gem']} -v '${name['ver']}'",
            timeout => 6000,
            path    => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
            require => Package['gem']
        }

    }

}