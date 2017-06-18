namespace :development do
  desc 'Start up development web server'
  task :up do
    system('rerun --background -- rackup --port=80 -o 0.0.0.0 config.ru')
  end
end