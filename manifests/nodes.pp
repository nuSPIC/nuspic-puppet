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

#    class { 'postfix':
#        settings => {
#            mydomain => $domain,
#            mydestination => $domain,
#            inet_interfaces => $infra_address,
#            mynetworks => "${infra_subnet} ${libvirt_subnet}",
#            relayhost => $infra_relayhost,
#        },
#    }

}

