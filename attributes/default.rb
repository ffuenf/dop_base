# # # # # # #
# hostname  #
# # # # # # #
node.set['dop_base']['hosts']['hostname'] = (node['dop_base'].attribute?('local_developer')) ? "dop-#{node['dop_base']['local_developer']}" : "dop"
node.set['dop_base']['hosts']['ipv4'] = [
	{"127.0.0.1" => "#{node['dop_base']['hosts']['hostname']}.local #{node['dop_base']['hosts']['hostname']}"}
]

# # # # # # # # #
# system locale #
# # # # # # # # #
node.set['dop_base']['locale'] = "en_US"

# # # # # # # # # #
# system timezone #
# # # # # # # # # #
node.set['dop_base']['timezone'] = "Europe/Berlin"

# # # # # # # # #
# system users  #
# # # # # # # # #
node.set['users']['deploy'] = nil

# # # # # # # # # #
# ssh known hosts #
# # # # # # # # # #
node.set['dop_base']['ssh_known_hosts_entry'] = [ 'github.com' ]

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
node.set['dop_base']['git']['user'] = node['dop_base']['hostname']
node.set['dop_base']['git']['email'] = "git@#{node['dop_base']['hostname']}"

# # # # # # #
# packages  #
# # # # # # #
node.set['dop_base']['packages'] = {
	"htop",
	"nmap"
}