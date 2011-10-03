# ZYV

class nuspic {

    include nuspic::install

}

class nuspic::install {

    $packages_nuspic = [
        'MySQL-python',
        'python-cjson',
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

    include nuspic::user

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
