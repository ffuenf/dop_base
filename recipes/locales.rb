#
# Cookbook Name:: dop_base
# Recipe:: locales
#

bash "generate locales" do
	code <<-EOC
		sudo locale-gen #{node['dop_base']['locale']}
		sudo update-locale LANG=#{node['dop_base']['locale']}
		sudo update-locale LC_ALL=#{node['dop_base']['locale']}
		sudo dpkg-reconfigure -f noninteractive locales
	EOC
end