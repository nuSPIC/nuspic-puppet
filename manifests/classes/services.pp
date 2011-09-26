# ZYV

#
# Packages installed by default
#
class services::packages {

    $packages_to_install = [
        'git',
        'logwatch',
        'mc',
        'screen',
    ]

    package { $packages_to_install :
        ensure => 'present',
    }

}

class services::puppet {

    package { 'puppet' :
        ensure => 'present',
    }

    service { 'puppet' :
        enable => 'false',
        ensure => 'stopped',
    }

}

#
# Services that should be enabled by default
#
#class services::enabled {
#
#    $services_to_enable = [
#    ]
#
#    service { $services_to_enable :
#        enable => 'true',
#        ensure => 'running',
#    }
#
#}

#
# Services that should be disabled by default
#
class services::disabled {

    $services_to_disable = [
        'abrtd',
        'avahi-daemon',
        'iscsi',
        'iscsid',
        'kdump',
        'netfs',
        'nfs',
        'nfslock',
        'rpcbind',
        'rpcgssd',
        'rpcidmapd',
        'sysstat',
    ]

    service { $services_to_disable :
        enable => 'false',
        ensure => 'stopped',
    }

}
