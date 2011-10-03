# ZYV

class nginx {

    include nginx::install
    include nginx::config
    include nginx::service

}

class nginx::install {

    package { 'nginx':
        ensure => 'present',
    }

}

class nginx::config {

    File {
        notify => Class['nginx::service'],
        require => Class['nginx::install'],
    }

    file { '/etc/nginx/nginx.conf':
        ensure => 'file',
        source => "${infra_files}/nginx/nginx.conf",
    }

    file { '/etc/nginx/conf.d/default.conf':
        ensure => 'file',
        source => "${infra_files}/nginx/conf.d/default.conf",
    }

    file { '/etc/nginx/conf.d/htpasswd-admin':
        ensure => 'file',
        source => "${infra_files}/nginx/conf.d/htpasswd-admin",
    }

}

class nginx::service {

    service { 'nginx':
        enable => 'true',
        ensure => 'running',
        require => [
            Class['nginx::config'],
            Class['nginx::install'],
        ]
    }

}

