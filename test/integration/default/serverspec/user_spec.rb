require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin'
  end
end

describe user('dop_deploy') do
  it { should exist }
  it { should have_home_directory '/home/dop_deploy' }
  it { should have_authorized_key 'ssh-rsa ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGH foo@bar.local' }
end

describe group('dop_deploy') do
  it { should exist }
end

describe file('/home/dop_deploy/wrap-ssh4git.sh') do
  it { should be_file }
  it { should be_mode 700 }
  it { should be_owned_by 'dop_deploy' }
  it { should be_grouped_into 'dop_deploy' }
end

describe file('/home/dop_deploy/.ssh/config') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'dop_deploy' }
  it { should be_grouped_into 'dop_deploy' }
end

describe file('/home/dop_deploy/.gemrc') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'dop_deploy' }
  it { should be_grouped_into 'dop_deploy' }
end

describe file('/home/dop_deploy/.gitignore_global') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'dop_deploy' }
  it { should be_grouped_into 'dop_deploy' }
end

describe file('/home/dop_deploy/.gitconfig') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'dop_deploy' }
  it { should be_grouped_into 'dop_deploy' }
end

describe file('/home/dop_deploy/.gitconfig') do
  its(:content) { should match /email = dop_deploy@dop/ }
  its(:content) { should match /name = dop_deploy/ }
end

describe user('dop_service') do
  it { should exist }
  it { should have_home_directory '/home/dop_service' }
  it { should have_authorized_key 'ssh-rsa ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGH foo@bar.local' }
end

describe group('dop_service') do
  it { should exist }
end