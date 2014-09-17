#
# Cookbook Name:: dop_base
# Recipe:: default
#

include_recipe 'hostnames'
include_recipe 'sshd'
include_recipe 'ssh'
include_recipe 'dotdeb' if node['platform'] == 'debian'
include_recipe 'ntp'
include_recipe 'sysctl'
include_recipe 'git'
include_recipe 'htpasswd'
include_recipe 'chef-sugar::default'
include_recipe 'dop_base::_user'
include_recipe 'dop_base::_timezone'
include_recipe 'dop_base::_locales'
include_recipe 'dop_base::_fail2ban'
include_recipe 'dop_base::_logrotate'
include_recipe 'apt_cleanup'

node['dop_base']['hosts']['hostnames'].each do |entry|
  hostsfile_entry 'set_hostnames' do
    ip_address entry['ip']
    hostname entry['hostname']
    aliases entry['aliases']
    unique true
    action :create
    notifies :reload, 'ohai[reload]', :immediately
  end
end
ohai 'reload' do
  action :nothing
end

node['dop_base']['ssh_known_hosts_entry'].each do |host|
  ssh_known_hosts host
end

template '/root/.bashrc' do
  source '.bashrc.erb'
end
template '/home/vagrant/.bashrc' do
  source '.bashrc.erb'
  only_if { vagrant? }
end

node['dop_base']['packages'].each do |pkg|
  package pkg
end
