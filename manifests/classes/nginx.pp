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
        require => Class['nginx::install'],
    }

    file { '/etc/nginx/nginx.conf':
        ensure => 'file',
        source => "${infra_files}/nginx/nginx.conf",
        notify => Class['nginx::service'],
    }

    file { '/etc/nginx/conf.d/default.conf':
        ensure => 'file',
        source => "${infra_files}/nginx/conf.d/default.conf",
        notify => Class['nginx::service'],
    }

    file { '/etc/nginx/conf.d/htpasswd-admin':
        ensure => 'file',
        source => "${infra_files}/nginx/conf.d/htpasswd-admin",
        notify => Class['nginx::service'],
    }

    file { '/etc/logrotate.d/nginx':
        ensure => 'file',
        source => "${infra_files}/logrotate.d/nginx",
    }

    file { '/etc/nginx/misc':
        ensure => 'directory',
    }

    file { '/etc/nginx/misc/404.html':
        ensure => 'file',
        source => "${infra_files}/nginx/misc/404.html",
        require => File['/etc/nginx/misc'],
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

