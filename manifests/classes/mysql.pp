# ZYV

class mysql {

    include mysql::install
    include mysql::config
    include mysql::service

}

class mysql::install {

    package { [ 'mysql', 'mysql-server', ]:
        ensure => 'present',
    }

}

class mysql::config {

    file { '/etc/my.cnf':
        ensure => 'file',
        notify => Class['mysql::service'],
        require => Class['mysql::install'],
        source => "${infra_files}/my.cnf",
    }

}

class mysql::service {

    service { 'mysqld':
        enable => 'true',
        ensure => 'running',
        require => [
            Class['mysql::config'],
            Class['mysql::install'],
        ]
    }

}
