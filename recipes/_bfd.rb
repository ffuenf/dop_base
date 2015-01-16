#
# Cookbook Name:: dop_base
# Recipe:: _bfd
#
# Copyright 2015, Achim Rosenhagen
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

bfd_src_filename = ::File.basename(node['dop_base']['bfd']['url'])
bfd_src_filepath = "#{Chef::Config['file_cache_path']}/#{bfd_src_filename}"
bfd_extract_path = "#{Chef::Config['file_cache_path']}/"

unless bfd_version?(node['dop_base']['bfd']['version'])
  remote_file bfd_src_filepath do
    source node['dop_base']['bfd']['url']
    checksum node['dop_base']['bfd']['checksum']
    owner 'root'
    group 'root'
    mode 00644
  end
  execute 'extract_bfd' do
    cwd ::File.dirname(bfd_src_filepath)
    command "tar xzf #{bfd_src_filename} -C #{bfd_extract_path}"
  end
  execute 'install_bfd' do
    cwd "#{bfd_extract_path}/bfd-#{node['dop_base']['bfd']['version']}/"
    command './install.sh > /dev/null'
  end
end
