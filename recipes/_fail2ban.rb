#
# Cookbook Name:: dop_base
# Recipe:: _fail2ban
#

include_recipe 'fail2ban'

cookbook_file '/etc/fail2ban/filter.d/sshd.conf' do
  source 'fail2ban_filter_sshd'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, 'service[fail2ban]'
end

cookbook_file '/etc/fail2ban/filter.d/pure-ftpd.conf' do
  source 'fail2ban_filter_pure-ftpd'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, 'service[fail2ban]'
end

cookbook_file '/etc/fail2ban/filter.d/wordpress.conf' do
  source 'fail2ban_filter_wordpress'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, 'service[fail2ban]'
end

cookbook_file '/etc/fail2ban/filter.d/wp-spam.conf' do
  source 'fail2ban_filter_wp-spam'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, 'service[fail2ban]'
end

cookbook_file '/etc/fail2ban/filter.d/antispam-bee.conf' do
  source 'fail2ban_filter_antispam-bee'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, 'service[fail2ban]'
end

cookbook_file '/etc/fail2ban/filter.d/nginx-limitreq.conf' do
  source 'fail2ban_filter_nginx-limitreq'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, 'service[fail2ban]'
end
