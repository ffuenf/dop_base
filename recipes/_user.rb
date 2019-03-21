#
# Cookbook Name:: dop_base
# Recipe:: _user
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

include_recipe 'user'
include_recipe 'sudo'

ohai 'reload' do
  action :nothing
end

user_account node['users']['deploy']['username'] do
  ssh_keys node['users']['deploy']['ssh_keys']
  ssh_keygen false
  notifies :reload, 'ohai[reload]', :immediately
end

template "#{node['users']['deploy']['home']}/wrap-ssh4git.sh" do
  source 'wrap-ssh4git.sh.erb'
  variables(
    git: node['dop_base']['git']
  )
  owner node['users']['deploy']['username']
  group node['users']['deploy']['username']
  mode 0o700
end

if node['dop_base']['sshd_config']['use_custom_adjustments']
  if ubuntu_after_saucy? || debian_after_wheezy?
    ssh_config '*' do
      user node['users']['deploy']['username']
      options StrictHostKeyChecking: 'yes',
              UserKnownHostsFile: '/etc/ssh/ssh_known_hosts',
              ControlPersist: 'yes',
              ControlMaster: 'yes',
              ControlPath: '/tmp/%r@%h:%p',
              NoHostAuthenticationForLocalhost: 'yes',
              KexAlgorithms: 'curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256',
              Protocol: '2',
              HostKey: '/etc/ssh/ssh_host_ed25519_key',
              PasswordAuthentication: 'no',
              PubkeyAuthentication: 'yes',
              Ciphers: 'chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr',
              MACs: 'hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-ripemd160-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,hmac-ripemd160,umac-128@openssh.com'
    end
  else
    ssh_config '*' do
      user node['users']['deploy']['username']
      options StrictHostKeyChecking: 'yes',
              UserKnownHostsFile: '/etc/ssh/ssh_known_hosts',
              ControlPersist: 'yes',
              ControlMaster: 'yes',
              ControlPath: '/tmp/%r@%h:%p',
              NoHostAuthenticationForLocalhost: 'yes',
              KexAlgorithms: 'diffie-hellman-group-exchange-sha256',
              Protocol: '2',
              HostKey: '/etc/ssh/ssh_host_ed25519_key',
              PasswordAuthentication: 'no',
              PubkeyAuthentication: 'yes',
              Ciphers: 'aes256-ctr,aes192-ctr,aes128-ctr',
              MACs: 'hmac-sha2-512,hmac-sha2-256,hmac-ripemd160'
    end
  end
else
  ssh_config '*' do
    user node['users']['deploy']['username']
    options StrictHostKeyChecking: 'yes',
            UserKnownHostsFile: '/etc/ssh/ssh_known_hosts',
            ControlPersist: 'yes',
            ControlMaster: 'yes',
            ControlPath: '/tmp/%r@%h:%p',
            NoHostAuthenticationForLocalhost: 'yes',
            Protocol: '2',
            PasswordAuthentication: 'no',
            PubkeyAuthentication: 'yes'
  end
end

cookbook_file "#{node['users']['deploy']['home']}/.gemrc" do
  source 'gemrc'
  owner node['users']['deploy']['username']
  group node['users']['deploy']['username']
  mode 0o644
end

cookbook_file "#{node['users']['deploy']['home']}/.gitignore_global" do
  source 'gitignore_global'
  owner node['users']['deploy']['username']
  group node['users']['deploy']['username']
  mode 0o644
end

template "#{node['users']['deploy']['home']}/.gitconfig" do
  source 'gitconfig.erb'
  variables(
    git: node['dop_base']['git']
  )
  owner node['users']['deploy']['username']
  group node['users']['deploy']['username']
  mode 0o644
end
template "#{node['users']['deploy']['home']}/.bashrc" do
  source '.bashrc.erb'
  not_if { vagrant? }
end

user_account node['users']['service']['username'] do
  comment node['users']['service']['comment']
  ssh_keys node['users']['service']['ssh_keys']
  ssh_keygen false
  home node['users']['service']['home']
  notifies :reload, 'ohai[reload]', :immediately
end
