require 'rspec/core/rake_task'

task :test => 'test:all'

namespace :test do
  desc 'Run all tests'
  task all: [:features, :end2end]

  desc 'Run feature tests'
  RSpec::Core::RakeTask.new :features do |test, args|
    test.pattern = Dir['./spec/features/**/*_spec.rb']
  end

  desc 'Run end2end tests'
  RSpec::Core::RakeTask.new :end2end do |test, args|
    test.pattern = Dir['./spec/end2end/**/*_spec.rb']
  end
end