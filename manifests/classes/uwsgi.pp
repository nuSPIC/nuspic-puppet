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

