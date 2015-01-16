require_relative '../../../kitchen/data/spec_helper'

describe package('logrotate') do
  it { should be_installed }
end

describe file('/etc/logrotate.d/fail2ban') do
  it { should be_file }
  it { should be_mode 440 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
