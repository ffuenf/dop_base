#
# Cookbook Name:: dop_base
# Recipe:: _maldetect
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

maldetect_src_filename = ::File.basename(node['dop_base']['maldetect']['url'])
maldetect_src_filepath = "#{Chef::Config['file_cache_path']}/#{maldetect_src_filename}"
maldetect_extract_path = "#{Chef::Config['file_cache_path']}/"

unless maldetect_version?(node['dop_base']['maldetect']['version'])
  remote_file maldetect_src_filepath do
    source node['dop_base']['maldetect']['url']
    checksum node['dop_base']['maldetect']['checksum']
    owner 'root'
    group 'root'
    mode 00644
  end
  execute 'extract_maldetect' do
    cwd ::File.dirname(maldetect_src_filepath)
    command "tar xzf #{maldetect_src_filename} -C #{maldetect_extract_path}"
  end
  execute 'install_maldetect' do
    cwd "#{maldetect_extract_path}/maldetect-#{node['dop_base']['maldetect']['version']}/"
    command './install.sh > /dev/null'
  end
end
