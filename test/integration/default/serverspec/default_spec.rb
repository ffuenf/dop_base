require_relative '../../../kitchen/data/spec_helper'

describe host('localhost') do
  it { should be_resolvable.by('hosts') }
  it { should be_reachable }
  its(:ipaddress) { should eq '::1' }
end

describe file('/root/.ssh') do
  it { should be_directory }
  it { should be_mode 700 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

%w[
  htop
  nmap
  siege
  python-pip
  libxml-xpath-perl
  rsync
  zip
  bmon
  cbm
  curl
  dstat
  iftop
  iotop
  ngrep
  netcat
  screen
  strace
  sysstat
].each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe file('/etc/default/sysstat') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe service('ntp') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/ssh/ssh_host_rsa_key') do
  it { should be_file }
  it { should be_mode 600 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

if os[:family] == 'ubuntu' && os[:release] == '14.04' || os[:family] == 'debian' && os[:release] == '8.0'
  describe file('/etc/ssh/ssh_host_ed25519_key') do
    it { should be_file }
    it { should be_mode 600 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end
end

describe command('grep -qi " 1023 " /etc/ssh/moduli') do
  its(:exit_status) { should eq 1 }
end
describe command('grep -qi " 1535 " /etc/ssh/moduli') do
  its(:exit_status) { should eq 1 }
end
