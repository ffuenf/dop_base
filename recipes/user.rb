#
# Cookbook Name:: dop_base
# Recipe:: user
#

include_recipe "user"
include_recipe "sudo"

user_account node['users']['deploy']['name'] do
	ssh_keys node['users']['deploy']['ssh_keys']
	ssh_keygen false
end

sudo node['users']['deploy']['name']

cookbook_file "#{node['users']['deploy']['home']}/wrap-ssh4git.sh" do
	source "wrap-ssh4git.sh"
	owner node['users']['deploy']['name']
	owner node['users']['deploy']['name']
	mode 0700
end

cookbook_file "#{node['users']['deploy']['home']}/.ssh/config" do
	source "ssh_config"
	owner node['users']['deploy']['name']
	group node['users']['deploy']['name']
	mode 0644
end

cookbook_file "#{node['users']['deploy']['home']}/.gemrc" do
	source "gemrc"
	owner node['users']['deploy']['name']
	group node['users']['deploy']['name']
	mode 0644
end

cookbook_file "#{node['users']['deploy']['home']}/.gitignore_global" do
	source "gitignore_global"
	owner node['users']['deploy']['name']
	group node['users']['deploy']['name']
	mode 0644
end

template "#{node['users']['deploy']['home']}/.gitconfig" do
	source "gitconfig.erb"
	variables({
		:git => node['dop_base']['git']
	})
	owner node['users']['deploy']['name']
	owner node['users']['deploy']['name']
	mode 0644
end