#
# Cookbook Name:: dop_base
# Recipe:: _awscli
#

package 'rsync'
include_recipe 'python'
python_pip 'awscli'

directory "#{node['users']['deploy']['home']}/.aws"
template "#{node['users']['deploy']['home']}/.aws/config" do
  source 'awsconfig.erb'
  variables(
    aws: node['users']['deploy']['aws']
  )
  owner node['users']['deploy']['name']
  group node['users']['deploy']['group']
  mode 0644
end
