# ZYV

class nuspic {

    include nuspic::user
    include nuspic::install
    include nuspic::config
    include nuspic::service

    include nuspic::storage

}

class nuspic::install {

    $packages_nuspic = [
        'MySQL-python',
        'python-anyjson',
        'python-cjson',
        'python-simplejson',
        'python-django',
        'python-django-bbmarkup',
        'python-django-celery',
        'python-django-form-utils',
        'python-django-kombu',
        'python-django-picklefield',
        'python-django-reversion',
        'python-nest',
        'python-networkx',
        'python-recaptcha-client',
    ]

    package { $packages_nuspic :
        ensure => 'present',
    }

    file { '/srv/apps/nuspic':
        ensure => 'directory',
        mode => '0644',
        group => 'nuspic',
        owner => 'nuspic',
        recurse => 'true',
        require => Class['nuspic::user'],
    }

}

class nuspic::user {

    user { 'nuspic':
        comment => 'Puppet-managed nuSPIC webapp account',
        ensure => 'present',
        gid => 'nuspic',
        home => '/srv/apps/nuspic',
        managehome => 'true',
        shell => '/bin/nologin',
    }

    group { 'nuspic':
        ensure => 'present',
        system => 'false',
    }

}

class nuspic::config {

    file { '/etc/sysconfig/celeryd':
        ensure => 'file',
        notify => Class['nuspic::service'],
        require => Class['nuspic::install'],
        source => "${infra_files}/sysconfig/celeryd",
    }

    file { '/etc/logrotate.d/celeryd':
        ensure => 'file',
        require => Class['nuspic::install'],
        source => "${infra_files}/logrotate.d/celeryd",
    }

    file { '/srv/apps/nuspic/.nestrc':
        ensure => 'file',
        owner => 'nuspic',
        group => 'nuspic',
        require => Class['nuspic::user'],
        source => "${infra_files}/.nestrc",
    }

}

class nuspic::service {

    service { 'celeryd':
        enable => 'true',
        ensure => 'running',
        require => [
            Class['nuspic::config'],
            Class['nuspic::install'],
        ]
    }

}

class nuspic::storage {

}
