require 'serverspec'
set :backend, :exec
set :path, '/sbin:/usr/sbin:/usr/local/sbin:$PATH'

describe command('echo $LC_ALL'), if: os[:family] == 'debian' do
  its(:stdout) { should match /en_US.UTF-8/ }
end
