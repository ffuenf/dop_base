require_relative '../../../kitchen/data/spec_helper'

describe file('/etc/cron.daily/apf') do
  it { should be_file }
  it { should be_executable }
end

describe file('/usr/local/sbin/apf') do
  it { should be_file }
  it { should be_executable }
end
