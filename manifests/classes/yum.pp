# ZYV

class yum {

    include yum::priorities
    include yum::local

}

#
# Local yum repositories for Red Hat based hosts
#
class yum::local {

    yumrepo { 'rhel-local':
        baseurl => 'file:///srv/infra/repos/rhel-6Server-local',
        descr => 'Red Hat Enterprise Linux $releasever - Local packages (ZYV)',
        enabled => '1',
        gpgcheck => '0',
        priority => $yum::priorities::params::prio_local,
    }

}

class yum::priorities {

    include yum::priorities::params
    include yum::priorities::install

    case "$operatingsystem" {
        /Scientific/: {
            include yum::priorities::scientific
        }
        default: { fail('Unsupported operating system') }
    }

}

class yum::priorities::params {

    $prio_local = '40'
    $prio_system = '50'
    $prio_addon = '60'

}

class yum::priorities::install {

    package { 'yum-plugin-priorities':
        ensure => 'present',
    }

}

class yum::priorities::scientific {

    $prio = $yum::priorities::params::prio_system

    augeas { 'scientific_linux_priorities':
        context => '/files/etc/yum.repos.d',
        changes => [
            "set sl.repo/sl/priority ${prio}",
            "set sl.repo/sl-security/priority ${prio}",
            "set sl.repo/sl-source/priority ${prio}",
            "set sl-other.repo/sl-fastbugs/priority ${prio}",
            "set sl-other.repo/sl-debuginfo/priority ${prio}",
            "set sl-other.repo/sl-testing/priority ${prio}",
            "set sl-other.repo/sl-testing-source/priority ${prio}",
        ],
        require => Class['yum::priorities::install'],
    }

}

