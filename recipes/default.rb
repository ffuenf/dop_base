#
# Cookbook Name:: dop_base
# Recipe:: default
#
# Copyright 2016, Achim Rosenhagen
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

node.normal['users']['deploy'] = data_bag_item('users', 'deploy')
node.normal['users']['service'] = data_bag_item('users', 'service')
node.normal['dop_base']['git']['user'] = node['users']['deploy']['username']
node.normal['dop_base']['git']['email'] = "#{node['users']['deploy']['username']}@#{node['dop_base']['hosts']['hostname']}"
node.normal['authorization']['sudo']['users'] = [node['users']['deploy']['username'].to_s]

include_recipe 'build-essential'
include_recipe 'chef-sugar'
include_recipe 'hostnames'
if node['dop_base']['sshd_config']['use_custom_adjustments']
  if ubuntu_after_saucy? || debian_after_wheezy?
    node.default['sshd']['sshd_config']['KexAlgorithms'] = 'curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256'
    node.default['sshd']['sshd_config']['Ciphers'] = 'chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr'
    node.default['sshd']['sshd_config']['MACs'] = 'hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-ripemd160-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,hmac-ripemd160,umac-128@openssh.com'
  else
    node.default['sshd']['sshd_config']['KexAlgorithms'] = 'diffie-hellman-group-exchange-sha256'
    node.default['sshd']['sshd_config']['Ciphers'] = 'aes256-ctr,aes192-ctr,aes128-ctr'
    node.default['sshd']['sshd_config']['MACs'] = 'hmac-sha2-512,hmac-sha2-256,hmac-ripemd160'
  end
end
include_recipe 'sshd'
include_recipe 'ssh'
include_recipe 'dotdeb' if debian?
include_recipe 'ntp'
include_recipe 'sysctl'
include_recipe 'git'
include_recipe 'htpasswd'
include_recipe 'chef-sugar'
include_recipe 'dop_base::_user'
include_recipe 'dop_base::_timezone'
include_recipe 'dop_base::_locales'
include_recipe 'dop_base::_fail2ban'
include_recipe 'dop_base::_logrotate'
include_recipe 'dop_base::_awscli'
include_recipe 'chef_handler'

node['dop_base']['hosts']['hostnames'].each do |entry|
  hostsfile_entry 'set_hostnames' do
    ip_address entry['ip']
    hostname entry['hostname']
    aliases entry['aliases']
    action :create_if_missing
    notifies :reload, 'ohai[reload]', :immediately
  end
end

directory '/root/.ssh' do
  owner 'root'
  group 'root'
  mode 0o700
end
node['ssh_known_hosts']['entries'].each do |host|
  ssh_known_hosts host
end

template '/root/.bashrc' do
  source '.bashrc.erb'
end
template '/home/vagrant/.bashrc' do
  source '.bashrc.erb'
  only_if { vagrant? }
end
cookbook_file '/home/vagrant/tmp_npm.sh' do
  owner 'root'
  group 'root'
  mode 0o755
  only_if { vagrant? }
end
cookbook_file '/home/vagrant/tmp_npm.sh' do
  mode 0o755
  only_if { vagrant? }
end

node['dop_base']['packages'].each do |pkg|
  package pkg
end

# Message on login
template '/etc/motd' do
  source 'motd.erb'
  mode 0o755
  backup 0
end

cookbook_file '/etc/default/sysstat' do
  owner 'root'
  group 'root'
  mode 0o644
end

execute 'clear moduli' do
  command 'grep -v " 1023 " /etc/ssh/moduli > /etc/ssh/moduli.temp && mv /etc/ssh/moduli.temp /etc/ssh/moduli'
  only_if { node['dop_base']['sshd_config']['use_custom_adjustments'] }
end
execute 'clear moduli' do
  command 'grep -v " 1535 " /etc/ssh/moduli > /etc/ssh/moduli.temp && mv /etc/ssh/moduli.temp /etc/ssh/moduli'
  only_if { node['dop_base']['sshd_config']['use_custom_adjustments'] }
end

bash 'generate rsa host-key' do
  cwd '/etc/ssh'
  code <<-EOC
  rm ssh_host_*key*
  ssh-keygen -t rsa -b 4096 -f ssh_host_rsa_key -N ''
  EOC
  only_if { node['dop_base']['sshd_config']['use_custom_adjustments'] }
end
bash 'generate ed25519 host-key' do
  cwd '/etc/ssh'
  code <<-EOC
  ssh-keygen -t ed25519 -f ssh_host_ed25519_key -N ''
  EOC
  only_if { node['dop_base']['sshd_config']['use_custom_adjustments'] && (ubuntu_after_saucy? || debian_after_wheezy?) }
end

ohai 'reload' do
  action :reload
end
