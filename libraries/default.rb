#
# Cookbook Name:: dop_base
# Library:: default
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

require 'chef/mixin/shell_out'
include Chef::Mixin::ShellOut

def maldetect_version?(version)
  cmdstr = "maldet | grep -qi 'Linux Malware Detect v#{version}'"
  cmd = Mixlib::ShellOut.new(cmdstr)
  cmd.run_command
  cmd.exitstatus.zero?
end

def bfd_version?(version)
  cmdstr = "bfd | grep -qi 'Brute Force Detection v#{version}'"
  cmd = Mixlib::ShellOut.new(cmdstr)
  cmd.run_command
  cmd.exitstatus.zero?
end

def apf_version?(version)
  cmdstr = "apf | grep -qi 'Adcanced Policy Firewall v#{version}'"
  cmd = Mixlib::ShellOut.new(cmdstr)
  cmd.run_command
  cmd.exitstatus.zero?
end
