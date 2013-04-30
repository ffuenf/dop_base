#
# Cookbook Name:: dop_base
# Recipe:: fail2ban
#

include_recipe "fail2ban"

cookbook_file "/etc/fail2ban/jail.local" do
	source "fail2ban_jail_local"
	owner "root"
	group "root"
	mode 0644
	notifies :restart, "service[fail2ban]"
end