# ZYV

class uwsgi {

    include uwsgi::install
    include uwsgi::config
    include uwsgi::service

}

class uwsgi::install {

    $packages_uwsgi = [
        'uwsgi',
        'uwsgi-plugin-python',
    ]

    package { $packages_uwsgi :
        ensure => 'present',
    }

}

class uwsgi::config {

    file { '/etc/uwsgi/vassals/nuspic.ini':
        ensure => 'file',
        require => Class['uwsgi::install'],
        source => "${infra_files}/uwsgi/vassals/nuspic.ini",
    }

    file { '/var/log/uwsgi/nuspic':
        ensure => 'directory',
        owner => 'nuspic',
        group => 'nuspic',
    }

    file { '/var/run/uwsgi/nuspic':
        ensure => 'directory',
        owner => 'nuspic',
        group => 'nuspic',
    }

}

class uwsgi::service {

    service { 'uwsgi':
        enable => 'true',
        ensure => 'running',
        require => [
            Class['uwsgi::config'],
            Class['uwsgi::install'],
        ]
    }

}

