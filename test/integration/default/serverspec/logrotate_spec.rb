require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin'
  end
end

describe package('logrotate') do
  it { should be_installed }
end

describe file('/etc/logrotate.d/fail2ban') do
  it { should be_file }
  it { should be_mode 440 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
