require 'serverspec'
set :backend, :exec
set :path, '/sbin:/usr/sbin:/usr/local/sbin:$PATH'

describe package('rsync') do
  it { should be_installed }
end

describe file('/home/dop_deploy/.aws/config') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'dop_deploy' }
  it { should be_grouped_into 'dop_deploy' }
end
