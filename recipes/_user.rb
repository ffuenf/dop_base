#
# Cookbook Name:: dop_base
# Recipe:: user
#

include_recipe 'user'
include_recipe 'sudo'

user_account node['users']['deploy']['name'] do
  ssh_keys node['users']['deploy']['ssh_keys']
  ssh_keygen false
end

template "#{node['users']['deploy']['home']}/wrap-ssh4git.sh" do
  source 'wrap-ssh4git.sh.erb'
  variables(
    git: node['dop_base']['git']
  )
  owner node['users']['deploy']['name']
  group node['users']['deploy']['group']
  mode 0700
end

cookbook_file "#{node['users']['deploy']['home']}/.ssh/config" do
  source 'ssh_config'
  owner node['users']['deploy']['name']
  group node['users']['deploy']['group']
  mode 0644
end

cookbook_file "#{node['users']['deploy']['home']}/.gemrc" do
  source 'gemrc'
  owner node['users']['deploy']['name']
  group node['users']['deploy']['group']
  mode 0644
end

cookbook_file "#{node['users']['deploy']['home']}/.gitignore_global" do
  source 'gitignore_global'
  owner node['users']['deploy']['name']
  group node['users']['deploy']['group']
  mode 0644
end

template "#{node['users']['deploy']['home']}/.gitconfig" do
  source 'gitconfig.erb'
  variables(
    git: node['dop_base']['git']
  )
  owner node['users']['deploy']['name']
  group node['users']['deploy']['group']
  mode 0644
end
template "#{node['users']['deploy']['home']}/.bashrc" do
  source '.bashrc.erb'
  not_if { vagrant? }
end

user_account node['users']['service']['name'] do
  comment node['users']['service']['comment']
  ssh_keys node['users']['service']['ssh_keys']
  ssh_keygen false
  home node['users']['service']['home']
end
