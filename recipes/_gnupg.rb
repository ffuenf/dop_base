#
# Cookbook Name:: dop_base
# Recipe:: _gnupg
#

include_recipe 'bsw_gpg'

bsw_gpg_load_key_from_string 'set gpg keys' do
  key_contents node['users']['deploy']['gpg']['key']
  for_user node['users']['deploy']['name']
  not_if { ::File.directory?("#{node['users']['deploy']['home']}/.gnupg") }
end
