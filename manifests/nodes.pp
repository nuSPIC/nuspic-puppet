# ZYV

$infra_files = '/etc/puppet/files'
$infra_path = '/srv/infra'
$infra_config = '/opt/config'

node 'nuspic.g-node.org' {

    include yum::repos

    include network::hosts
    include network::iptables
    include network::ipv6::disable

    include services::ntpd

#    include services::disabled
#    include services::git
#    include services::logwatch
#
#    include puppet::client

    include openssh
    include openssh::install::xauth

    include postfix

}

