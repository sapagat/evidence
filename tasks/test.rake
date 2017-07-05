require 'rspec/core/rake_task'

task :test => 'test:all'

namespace :test do
  desc 'Run all tests'
  task all: [:services, :features, :health, :end2end]

  desc 'Run services tests'
  RSpec::Core::RakeTask.new :services do |test, args|
    test.pattern = Dir['./spec/services/**/*_spec.rb']
  end

  desc 'Run features tests'
  RSpec::Core::RakeTask.new :features do |test, args|
    test.pattern = Dir['./spec/features/**/*_spec.rb']
  end

  desc 'Run health test'
  RSpec::Core::RakeTask.new :health do |test, args|
    test.pattern = Dir['./spec/health/**/*_spec.rb']
  end

  desc 'Run end2end tests'
  RSpec::Core::RakeTask.new :end2end do |test, args|
    test.pattern = Dir['./spec/end2end/**/*_spec.rb']
  end
end