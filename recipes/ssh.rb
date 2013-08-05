#
# Cookbook Name:: dop_base
# Recipe:: ssh
#

cookbook_file "/etc/ssh/sshd_config" do
	source "sshd_config"
	owner "root"
	group "root"
	mode 0644
end

service "ssh" do
	supports :start => true, :stop => true, :reload => true, :restart => true, :status => true
	action [ :enable, :restart ]
end