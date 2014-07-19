#
# Cookbook Name:: dop_base
# Recipe:: default
#

execute "set_hostname" do
	command "hostname #{node['dop_base']['hosts']['hostname']}"
end

template "/etc/hosts" do
	source "hosts.erb"
	variables({
		:hosts => node['dop_base']['hosts']
	})
	owner "root"
	owner "root"
	mode 0644
end

include_recipe "dop_base::user"
include_recipe "dop_base::timezone"
include_recipe "dop_base::locales"
include_recipe "dop_base::ssh"
include_recipe "dop_base::fail2ban"
include_recipe "dotdeb" if node["platform"] == "debian"
include_recipe "git"
include_recipe "htpasswd"
include_recipe "dop_base::logrotate"

node["dop_base"]["ssh_known_hosts_entry"].each do |host|
	ssh_known_hosts_entry host
end

node["dop_base"]["packages"].each do |pkg|
	package pkg
end