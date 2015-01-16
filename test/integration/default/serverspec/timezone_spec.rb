require_relative '../../../kitchen/data/spec_helper'

describe command('cat /etc/timezone') do
  its(:stdout) { should match 'Europe/Berlin' }
end
