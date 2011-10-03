# ZYV

class nginx {

    include nginx::install

}

class nginx::install {

    package { 'nginx':
        ensure => 'present',
    }

}


