# config valid for current version and patch releases of Capistrano
lock "~> 3.13.0"

set :application, "seu"
set :repo_url, "git@gitlab.com:danielarrais/seu.git"

set :deploy_to, "/var/www/seu"

append :linked_files, "config/database.yml", "config/master.key"
append :linked_dirs, "log", "tmp"

set :keep_releases, 5
set :migration_role, :app

set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_access_log, "#{shared_path}/log/puma_access.log"
set :puma_error_log, "#{shared_path}/log/puma_error.log"

set :nginx_sites_available_path, "/etc/nginx/sites-available"
set :nginx_sites_enabled_path, "/etc/nginx/sites-enabled"

set :rvm_ruby_version, '2.7.0'

namespace :puma do
  desc 'Create Puma dirs'
  task :create_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  desc "Restart Nginx"
  task :nginx_restart do
    on roles(:app) do
      execute "sudo service nginx restart"
    end
  end

  before :start, :create_dirs
  after :start, :nginx_restart
end

# namespace :git do
#   desc 'Runs any rake task, cap deploy:rake task=db:rollback'
#   task seed_db: [:set_rails_env] do
#     on release_roles([:db]) do
#       within release_path do
#         with rails_env: fetch(:rails_env) do
#           execute :rake, 'db:seed'
#         end
#       end
#     end
#   end
#   # before :clone, :seed_db
# end

