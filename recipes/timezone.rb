#
# Cookbook Name:: dop_base
# Recipe:: timezone
#

bash "set_timezone" do
	code <<-EOF
		echo "#{node['dop_base']['timezone']}" > /etc/timezone
		dpkg-reconfigure -f noninteractive tzdata
	EOF
end