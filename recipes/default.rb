#
# Cookbook Name:: dop_base
# Recipe:: default
#

execute 'set_hostname' do
  command 'hostname #{node["dop_base"]["hosts"]["hostname"]}'
end

template '/etc/hosts' do
  source 'hosts.erb'
  variables(
    hosts: node['dop_base']['hosts']
  )
  owner 'root'
  owner 'root'
  mode 0644
end

include_recipe 'dotdeb' if node['platform'] == 'debian'
include_recipe 'ntp'
include_recipe 'sysctl'
include_recipe 'git'
include_recipe 'htpasswd'
include_recipe 'chef-sugar::default'
include_recipe 'dop_base::_user'
include_recipe 'dop_base::_timezone'
include_recipe 'dop_base::_locales'
include_recipe 'dop_base::_ssh'
include_recipe 'dop_base::_fail2ban'
include_recipe 'dop_base::_logrotate'

node['dop_base']['ssh_known_hosts_entry'].each do |host|
  ssh_known_hosts_entry host
end

node['dop_base']['packages'].each do |pkg|
  package pkg
end
