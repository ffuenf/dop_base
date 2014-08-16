require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin'
  end
end

describe command('echo $LANG') do
  it { should return_stdout 'en_US' }
end

describe command('echo $LC_ALL'), if: os[:family] == 'Debian' do
  it { should return_stdout 'en_US.UTF-8' }
end
