define rails::gems {

    include stdlib

    if is_string($name){

        exec { "rails::install_gem::${name}":
            command => "gem install ${name}",
            timeout => 6000,
            path    => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
            require => Package['gem']
        }

    } elsif is_hash($name) {
        $gem_name = pick(keys($name))
        $gem_ver = pick(values($name))

        exec { "rails::install_gem::${gem_name}-${gem_value}":
            command => "gem install ${gem_name} -v '${gem_value}'",
            timeout => 6000,
            path    => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
            require => Package['gem']
        }

    }

}