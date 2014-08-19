# # # # # # #
# hostname  #
# # # # # # #
default['dop_base']['hosts']['hostname'] = 'dop'
default['dop_base']['hosts']['ipv4'] = [
  {
    'ip' => '127.0.0.1',
    'domains' => [
      'localhost',
      node['dop_base']['hosts']['hostname']
    ]
  }
]
default['dop_base']['hosts']['ipv6'] = [
  {
    'ip' => '::1',
    'domains' => [
      'localhost',
      'ip6-localhost',
      'ip6-loopback'
    ]
  }
]

# # # # # # # # #
# system locale #
# # # # # # # # #
default['dop_base']['locale'] = 'en_US'

# # # # # # # # # #
# system timezone #
# # # # # # # # # #
default['dop_base']['timezone'] = 'Europe/Berlin'

# # # # # # # # #
# system users  #
# # # # # # # # #
default['users']['deploy'] = Chef::EncryptedDataBagItem.load('users', 'deploy')
default['users']['service'] = Chef::EncryptedDataBagItem.load('users', 'service')

# # # # # # # # # #
# ssh known hosts #
# # # # # # # # # #
default['dop_base']['ssh_known_hosts_entry'] = %w(github.com bitbucket.org)

# # # # #
# sudo  #
# # # # #
default['authorization']['sudo']['groups'] = ['sudo']
default['authorization']['sudo']['users'] = [node['users']['deploy']['name']]
default['authorization']['sudo']['passwordless'] = true
default['authorization']['sudo']['include_sudoers_d'] = true
default['authorization']['sudo']['agent_forwarding'] = true
default['authorization']['sudo']['sudoers_defaults'] = %w(env_reset env_keep=SSH_AUTH_SOCK)

# # # # # # #
# fail2ban  #
# # # # # # #
default['fail2ban']['email'] = 'root@localhost'

# # # #
# git #
# # # #
default['dop_base']['git']['wrapper_port'] = nil
default['dop_base']['git']['user'] = node['users']['deploy']['name']
default['dop_base']['git']['email'] = "#{node['users']['deploy']['name']}@#{node['dop_base']['hosts']['hostname']}"

# # # # # #
# sysctl  #
# # # # # #
default['sysctl']['params']['vm.overcommit_memory'] = 1

# # # # # # #
# packages  #
# # # # # # #
default['dop_base']['packages'] = %w(htop nmap siege python-pip libxml-xpath-perl)
