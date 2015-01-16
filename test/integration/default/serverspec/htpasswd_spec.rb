require_relative '../../../kitchen/data/spec_helper'

describe package('apache2-utils') do
  it { should be_installed }
end
