#
# Cookbook Name:: dop_base
# Recipe:: user
#

include_recipe 'user'
include_recipe 'sudo'

ohai 'reload' do
  action :nothing
end

user_account node['users']['deploy']['name'] do
  ssh_keys node['users']['deploy']['ssh_keys']
  ssh_keygen false
  notifies :reload, 'ohai[reload]', :immediately
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

ssh_config '*' do
  user node['users']['deploy']['name']
  options StrictHostKeyChecking: 'no',
          UserKnownHostsFile: '/etc/ssh/ssh_known_hosts',
          ControlPersist: 'yes',
          ControlMaster: 'yes',
          ControlPath: '/tmp/%r@%h:%p',
          NoHostAuthenticationForLocalhost: 'yes'
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
  notifies :reload, 'ohai[reload]', :immediately
end
