#
# Cookbook Name:: dop_base
# Recipe:: _gnupg
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

include_recipe 'bsw_gpg'

bsw_gpg_load_key_from_string 'set gpg keys' do
  key_contents node['users']['deploy']['gpg']['key']
  for_user node['users']['deploy']['username']
  not_if { ::File.directory?("#{node['users']['deploy']['home']}/.gnupg") }
end
