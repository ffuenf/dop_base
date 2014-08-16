require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin'
  end
end

describe host('dop') do
  it { should be_resolvable.by('hosts') }
end

describe file('/etc/ssh/ssh_known_hosts') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

%w(htop nmap siege python-pip libxml-xpath-perl ntp ntpdate).each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe service('ntp') do
  it { should be_enabled }
  it { should be_running }
end
