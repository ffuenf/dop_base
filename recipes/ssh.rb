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
	case node["platform"]
	when "ubuntu"
		if node["platform_version"].to_f >= 9.10
			provider Chef::Provider::Service::Upstart
		end
	end
	supports :start => true, :stop => true, :reload => true, :restart => true, :status => true
	action [ :enable, :restart ]
end