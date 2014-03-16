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

describe package('htop') do
  it { should be_installed }
end

describe file('/etc/ssh/ssh_known_hosts') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match /github.com/ }
end

describe package('nmap') do
  it { should be_installed }
end