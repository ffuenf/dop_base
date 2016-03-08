# # # # # # #
# hostname  #
# # # # # # #
default['sshd']['sshd_config']['PermitRootLogin'] = 'no'
default['sshd']['sshd_config']['PasswordAuthentication'] = 'no'
default['sshd']['sshd_config']['PubkeyAuthentication'] = 'yes'
default['sshd']['sshd_config']['UseDNS'] = 'no'
default['dop_base']['sshd_config']['use_custom_adjustments'] = false

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

# # # # # # # # # #
# ssh known hosts #
# # # # # # # # # #
default['ssh_known_hosts']['entries'] = %w(github.com bitbucket.org)

# # # # #
# sudo  #
# # # # #
default['authorization']['sudo']['groups'] = ['sudo']
default['authorization']['sudo']['passwordless'] = true
default['authorization']['sudo']['include_sudoers_d'] = true
default['authorization']['sudo']['agent_forwarding'] = true
default['authorization']['sudo']['sudoers_defaults'] = %w(env_reset env_keep=SSH_AUTH_SOCK)

# # # # # # #
# fail2ban  #
# # # # # # #
default['fail2ban']['email'] = 'root@localhost'
default['fail2ban']['banaction'] = 'iptables-multiport'

# # # #
# git #
# # # #
default['dop_base']['git']['wrapper_port'] = nil

# # # # # #
# sysctl  #
# # # # # #
default['sysctl']['params']['vm.overcommit_memory'] = 1

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
