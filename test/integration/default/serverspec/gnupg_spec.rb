require_relative '../../../kitchen/data/spec_helper'

describe file('/home/dop_deploy/.gnupg') do
  it { should be_directory }
end

describe package('gnupg2') do
  it { should be_installed }
end
