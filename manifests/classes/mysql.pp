# ZYV

class mysql {

    include mysql::install

}

class mysql::install {

    package { [ 'mysql', 'mysql-server', ]:
        ensure => 'present',
    }

}

