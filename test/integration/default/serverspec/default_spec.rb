require 'serverspec'
set :backend, :exec
set :path, '/sbin:/usr/sbin:/usr/local/sbin:$PATH'

describe host('dop') do
  it { should be_resolvable.by('hosts') }
  it { should be_reachable }
  its(:ipaddress) { should eq '127.0.0.1' }
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
