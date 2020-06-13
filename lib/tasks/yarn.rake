# https://dev.to/vvo/a-rails-6-setup-guide-for-2019-and-2020-hf5#heroku-and-double-yarn-installs
# Disable the rake yarn:install, since the webpack will be executed
Rake::Task['yarn:install'].clear
namespace :yarn do
  task :install => [:environment] do
  end
end