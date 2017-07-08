namespace :development do
  desc 'Start up development web server'
  task :up => :configure do
    system('rerun --background -- rackup --port=80 -o 0.0.0.0 config.ru')
  end

  task :configure do
    require_relative '../config/initializers/s3'
    require_relative '../src/service/warehouse'

    S3Client.create_bucket
  end
end