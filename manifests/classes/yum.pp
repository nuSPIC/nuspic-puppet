# ZYV

#
# Local yum repositories for Red Hat based hosts
#
class yum::local {

    yumrepo { 'rhel-local':
        baseurl => 'file:///srv/infra/repos/rhel-6Server-local',
        descr => 'Red Hat Enterprise Linux $releasever - Local packages (ZYV)',
        enabled => '1',
        gpgcheck => '0',
    }

}
