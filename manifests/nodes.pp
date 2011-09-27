# ZYV

$infra_files = '/etc/puppet/files'
$infra_path = '/srv/infra'
$infra_config = '/opt/config'

node 'nuspic.g-node.org' {

    include yum::local

    include network::hosts
    include network::iptables
    include network::ipv6::disable

    include services::ntpd

    include services::disabled
    include services::packages

    include services::puppet

    include openssh
    include openssh::install::xauth

    class { 'postfix':
        settings => {
            inet_interfaces => '',
            mydestination => '',
            mynetworks => '',
        },
    }

}

