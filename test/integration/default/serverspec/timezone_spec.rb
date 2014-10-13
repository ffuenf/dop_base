require 'serverspec'
set :backend, :exec
set :path, '/sbin:/usr/sbin:/usr/local/sbin:$PATH'

describe command('cat /etc/timezone') do
  its(:stdout) { should match 'Europe/Berlin' }
end
