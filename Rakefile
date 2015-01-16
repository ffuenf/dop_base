require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'foodcritic'
require 'kitchen'

# Style tests. Rubocop and Foodcritic
namespace :style do
  desc 'Run Ruby style checks'
  RuboCop::RakeTask.new(:ruby)

  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:chef) do |t|
    t.options = {
      fail_tags: ['any']
    }
  end
end

desc 'Run all style checks'
task style: ['style:chef', 'style:ruby']

# Rspec and ChefSpec
desc 'Run ChefSpec examples'
RSpec::Core::RakeTask.new(:spec)

# Integration tests. Kitchen.ci
namespace :integration do
  desc 'Create fake encrypted databags'
  task :create_databags do
    system('knife solo data bag create users deploy --data-bag-path ./test/integration/default/data_bags/ --json-file .data_bags/users_deploy.json --secret-file .data_bags/insecure_databag_secret')
    system('knife solo data bag create users service --data-bag-path ./test/integration/default/data_bags/ --json-file .data_bags/users_service.json --secret-file .data_bags/insecure_databag_secret')
  end

  desc 'Run Test Kitchen with Vagrant'
  task vagrant: [:create_databags] do
    Kitchen.logger = Kitchen.default_file_logger
    Kitchen::Config.new.instances.each do |instance|
      instance.test(:always)
    end
  end

  desc 'Run Test Kitchen with cloud plugins'
  task cloud: [:create_databags] do
    if ENV['TRAVIS'] == 'true'
      Kitchen.logger = Kitchen.default_file_logger
      @loader = Kitchen::Loader::YAML.new(project_config: './.kitchen.cloud.yml')
      config = Kitchen::Config.new(loader: @loader)
      config.instances.each do |instance|
        instance.test(:always)
      end
    end
  end
end

desc 'Run all tests on Travis'
task travis: ['style', 'spec', 'integration:cloud']

# Default
task default: ['style', 'spec', 'integration:vagrant']
