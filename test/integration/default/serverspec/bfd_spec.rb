require_relative '../../../kitchen/data/spec_helper'

describe file('/etc/cron.daily/bfd') do
  it { should be_file }
  it { should be_executable }
end

describe file('/usr/local/sbin/bfd') do
  it { should be_file }
  it { should be_executable }
end
