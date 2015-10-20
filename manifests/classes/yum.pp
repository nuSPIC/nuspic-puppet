# ZYV

class yum {

    include yum::autoupdate
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
        priority => $yum::priorities::params::prio_system,
        require => Class['yum::priorities'],
    }

}

class yum::nginx {

    yumrepo { 'nginx-com':
        baseurl => 'http://nginx.org/packages/rhel/6/$basearch/',
        descr => 'nginx.com official binary packages for RHEL (ZYV)',
        enabled => '1',
        gpgcheck => '0',
        priority => $yum::priorities::params::prio_addon,
        require => Class['yum::priorities'],
    }

}

class yum::epel {

    package { 'epel-release' :
        ensure => 'present',
    }

    $prio = $yum::priorities::params::prio_addon

    augeas { 'epel-settings':
        context => '/files/etc/yum.repos.d',
        changes => [
            "set epel.repo/epel/enabled 1",
            "set epel.repo/epel/priority $prio",
        ],
        require => Package['epel-release'],
    }

}

class yum::autoupdate {

    include yum::autoupdate::params
    include yum::autoupdate::install
    include yum::autoupdate::config

}

class yum::autoupdate::params {

    case "$operatingsystem" {
        /Scientific/: {
            # This is SL-specific package
            $pkgs = 'yum-autoupdate'
        }
        # RHN for Red Hat and yum-updatesd for Fedora / CentOS
        default: { fail('Unsupported operating system') }
    }

}

class yum::autoupdate::install {

    package { $yum::autoupdate::params::pkgs :
        ensure => 'present',
        require => Class['yum::autoupdate::params'],
    }

}

class yum::autoupdate::config {

    # Use yum-cron in the future! (available for both RHEL and SL)
    case "$operatingsystem" {
        /Scientific/: {
            file { '/etc/sysconfig/yum-autoupdate':
                ensure => 'file',
                source => "${infra_files}/sysconfig/yum-autoupdate",
                require => Class['yum::autoupdate::install'],
            }
        }
        default: { fail('Unsupported operating system') }
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

    $prio_high = '40'
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

