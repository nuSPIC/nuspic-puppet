# ZYV

#
# The Network Time Protocol (NTP) daemon
#
class services::ntpd {

    package { 'ntp':
        ensure => 'present',
    }

    file { '/etc/sysconfig/ntpd':
        ensure => 'file',
        notify => Service['ntpd'],
        require => Package['ntp'],
        source => "${infra_files}/sysconfig/ntpd",
    }

    service { 'ntpd':
        enable => 'true',
        ensure => 'running',
        require => Package['ntp'],
    }

}
