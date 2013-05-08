#
# Cookbook Name:: dop_base
# Recipe:: locales
#

bash "generate locales" do
	code <<-EOC
		locale-gen #{node['dop_base']['locale']}
		update-locale LANG=#{node['dop_base']['locale']}
		update-locale LC_ALL=#{node['dop_base']['locale']}
		dpkg-reconfigure -f noninteractive locales
	EOC
end