#
# Cookbook Name:: dop_base
# Recipe:: _fail2ban
#
# Copyright 2019, Achim Rosenhagen
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'fail2ban'

cookbook_file '/etc/fail2ban/filter.d/sshd.conf' do
  source 'fail2ban_filter_sshd'
  owner 'root'
  group 'root'
  mode 0o644
  notifies :restart, 'service[fail2ban]'
end

cookbook_file '/etc/fail2ban/filter.d/pure-ftpd.conf' do
  source 'fail2ban_filter_pure-ftpd'
  owner 'root'
  group 'root'
  mode 0o644
  notifies :restart, 'service[fail2ban]'
end

cookbook_file '/etc/fail2ban/filter.d/magento-backend.conf' do
  source 'fail2ban_filter_magento-backend'
  owner 'root'
  group 'root'
  mode 0o644
  notifies :restart, 'service[fail2ban]'
end

cookbook_file '/etc/fail2ban/filter.d/wordpress.conf' do
  source 'fail2ban_filter_wordpress'
  owner 'root'
  group 'root'
  mode 0o644
  notifies :restart, 'service[fail2ban]'
end

cookbook_file '/etc/fail2ban/filter.d/wp-spam.conf' do
  source 'fail2ban_filter_wp-spam'
  owner 'root'
  group 'root'
  mode 0o644
  notifies :restart, 'service[fail2ban]'
end

cookbook_file '/etc/fail2ban/filter.d/antispam-bee.conf' do
  source 'fail2ban_filter_antispam-bee'
  owner 'root'
  group 'root'
  mode 0o644
  notifies :restart, 'service[fail2ban]'
end

cookbook_file '/etc/fail2ban/filter.d/nginx-limitreq.conf' do
  source 'fail2ban_filter_nginx-limitreq'
  owner 'root'
  group 'root'
  mode 0o644
  notifies :restart, 'service[fail2ban]'
end
