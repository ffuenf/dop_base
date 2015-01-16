require_relative '../../../kitchen/data/spec_helper'

describe command('echo $LC_ALL'), if: os[:family] == 'debian' do
  its(:stdout) { should match 'en_US.UTF-8' }
end
