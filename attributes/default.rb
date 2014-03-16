# # # # # # #
# hostname  #
# # # # # # #
node.default['dop_base']['hosts']['hostname'] = "dop"
node.default['dop_base']['hosts']['ipv4'] = [
	{
		"ip" => "127.0.0.1",
		"domains" => [
			"localhost",
      node['dop_base']['hosts']['hostname']
		]
	}
]
node.default['dop_base']['hosts']['ipv6'] = [
	{
		"ip" => "::1",
		"domains" => [
			"localhost",
			"ip6-localhost",
			"ip6-loopback"
		]
	}
]

# # # # # # # # #
# system locale #
# # # # # # # # #
node.default['dop_base']['locale'] = "en_US"

# # # # # # # # # #
# system timezone #
# # # # # # # # # #
node.default['dop_base']['timezone'] = "Europe/Berlin"

# # # # # # # # #
# system users  #
# # # # # # # # #
node.set['users']['deploy'] = Chef::EncryptedDataBagItem.load("users", "deploy")
node.set['users']['service'] = Chef::EncryptedDataBagItem.load("users", "service")

# # # # # # # # # #
# ssh known hosts #
# # # # # # # # # #
node.default['dop_base']['ssh_known_hosts_entry'] = [ 'github.com' ]

# # # # #
# sudo  #
# # # # #
node.set['authorization']['sudo']['groups'] = [ "sudo" ]
node.set['authorization']['sudo']['users'] = [ node['users']['deploy']['name'] ]
node.set['authorization']['sudo']['passwordless'] = true
node.set['authorization']['sudo']['include_sudoers_d'] = true
node.set['authorization']['sudo']['agent_forwarding'] = true
node.set['authorization']['sudo']['sudoers_defaults'] = ['env_reset']

# # # # # # #
# fail2ban  #
# # # # # # #
node.set['fail2ban']['email'] = 'root@localhost'

# # # #
# git #
# # # #
node.default['dop_base']['git']['user'] = node['users']['deploy']['name']
node.default['dop_base']['git']['email'] = "#{node['users']['deploy']['name']}@#{node['dop_base']['hosts']['hostname']}"

# # # # # # #
# packages  #
# # # # # # #
node.default['dop_base']['packages'] = [
	"htop",
	"nmap"
]