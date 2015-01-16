#
# Cookbook Name:: dop_base
# Recipe:: _apf
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

apf_src_filename = ::File.basename(node['dop_base']['apf']['url'])
apf_src_filepath = "#{Chef::Config['file_cache_path']}/#{apf_src_filename}"
apf_extract_path = "#{Chef::Config['file_cache_path']}/"

unless apf_version?(node['dop_base']['apf']['version'])
  remote_file apf_src_filepath do
    source node['dop_base']['apf']['url']
    checksum node['dop_base']['apf']['checksum']
    owner 'root'
    group 'root'
    mode 00644
  end
  execute 'extract_apf' do
    cwd ::File.dirname(apf_src_filepath)
    command "tar xzf #{apf_src_filename} -C #{apf_extract_path}"
  end
  execute 'install_apf' do
    cwd "#{apf_extract_path}/apf-#{node['dop_base']['apf']['version']}/"
    command './install.sh > /dev/null'
  end
end

ruby_block 'deactivate devmode' do
  block do
    cnf = Chef::Util::FileEdit.new('/etc/apf/conf.apf')
    cnf.search_file_replace_line(/^DEVEL_MODE/, 'DEVEL_MODE="0"')
    cnf.write_file
  end
  not_if { node['dop_base']['apf']['devmode'] }
end

execute 'start_apf' do
  command 'apf -s'
end
