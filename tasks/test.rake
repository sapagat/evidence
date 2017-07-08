require 'rspec/core/rake_task'
require 'timeout'

task :test => 'test:all'

namespace :test do
  desc 'Run all tests'
  task all: [:services, :features, :health, :integration, :end2end]

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

  desc 'Run integration tests'
  RSpec::Core::RakeTask.new :integration do |test, args|
    test.pattern = Dir['./spec/integration/**/*_spec.rb']
  end

  desc 'Run end2end tests'
  RSpec::Core::RakeTask.new :end2end do |test, args|
    test.pattern = Dir['./spec/end2end/**/*_spec.rb']
  end

  desc 'Wait for environment to be ready'
  task :wait_for_environment do
    TIMEBOX = 20
    print 'Waiting for environment to be up and running... '
    begin
      Timeout.timeout(TIMEBOX) do
        loop do
          ready = system('bundle exec rake test:health', out: File::NULL, err: File::NULL)

          if ready
            puts 'READY!'
            exit 0
          end
        end
      end
    rescue Timeout::Error
      puts 'Timeout reached. ABORTING'
      exit 1
    end
  end
end