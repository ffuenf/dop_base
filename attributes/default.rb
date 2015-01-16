# # # # # # #
# hostname  #
# # # # # # #
default['sshd']['sshd_config']['PermitRootLogin'] = 'no'
default['sshd']['sshd_config']['PasswordAuthentication'] = 'no'
default['sshd']['sshd_config']['PubkeyAuthentication'] = 'yes'
default['sshd']['sshd_config']['UseDNS'] = 'no'

default['dop_base']['hosts']['hostname'] = 'dop'
default['dop_base']['hosts']['hostnames'] = [
  {
    'ip' => '127.0.0.1',
    'hostname' => 'localhost',
    'aliases' => [
      node['dop_base']['hosts']['hostname']
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
default['fail2ban']['banaction'] = 'apf'

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
# maldetect #
# # # # # # #
default['dop_base']['maldetect']['url'] = 'http://www.rfxn.com/downloads/maldetect-current.tar.gz'
default['dop_base']['maldetect']['version'] = '1.4.2'
default['dop_base']['maldetect']['checksum'] = 'dd2badb95f75ae90ed94892d799aedadc79498a72ef3502ab87f35509c76c094'

# # # #
# bfd #
# # # #
default['dop_base']['bfd']['url'] = 'http://www.rfxn.com/downloads/bfd-current.tar.gz'
default['dop_base']['bfd']['version'] = '1.5-2'
default['dop_base']['bfd']['checksum'] = 'c3fbce3a17156b047d4efc2b3398c5bf021af7578718f159cdaa2c40e0d4d0bc'

# # # #
# apf #
# # # #
default['dop_base']['apf']['url'] = 'http://www.rfxn.com/downloads/apf-current.tar.gz'
default['dop_base']['apf']['version'] = '9.7-2'
default['dop_base']['apf']['checksum'] = '793d83ca2657b86b86a23b1c3fe08ee436df8c4a83ef84c92f0f11689531a2cc'
default['dop_base']['apf']['devmode'] = true

# # # # # # #
# packages  #
# # # # # # #
default['dop_base']['packages'] = %w(
  htop
  nmap
  siege
  python-pip
  libxml-xpath-perl
  rsync
  zip
  bmon
  cbm
  curl
  dstat
  iftop
  iotop
  ngrep
  netcat
  screen
  strace
  sysstat
)
