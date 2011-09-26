# ZYV

#
# The Network Time Protocol (NTP) daemon
#
class services::ntpd {

    package { 'ntp':
        ensure => 'present',
    }

    service { 'ntpd':
        enable => 'true',
        ensure => 'running',
        require => Package['ntp'],
    }

}
