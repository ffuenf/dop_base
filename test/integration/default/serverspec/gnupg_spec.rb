require 'serverspec'
set :backend, :exec
set :path, '/sbin:/usr/sbin:/usr/local/sbin:$PATH'

describe file('/home/dop_deploy/.gnupg') do
  it { should be_directory }
end

describe package('gnupg2') do
  it { should be_installed }
end
