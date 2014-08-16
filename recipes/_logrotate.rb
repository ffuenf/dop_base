#
# Cookbook Name:: dop_base
# Recipe:: logrotate
#

include_recipe 'logrotate'

logrotate_app 'fail2ban' do
  cookbook 'logrotate'
  path '/var/log/fail2ban.log'
  frequency 'weekly'
  rotate 4
  create '644 root admin'
end
