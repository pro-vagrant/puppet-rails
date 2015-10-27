# To install stdlib module run:
# sudo puppet apply -e 'include rails'
#

include stdlib

class { ubuntu: stage => setup }

class { ruby: }

class { rails:
    require => Class['ruby']
}


