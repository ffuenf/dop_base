require_relative '../../../kitchen/data/spec_helper'

describe file('/root/.bashrc') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe service('ssh') do
  it { should be_enabled }
  it { should be_running }
end
