# config valid for current version and patch releases of Capistrano
lock '~> 3.14.1'

set :application, 'seu'
set :puma_role, :app
set :repo_url, 'git@gitlab.com:danielarrais/seu.git'

set :deploy_to, '/var/www/seu'

append :linked_files, 'config/database.yml', 'config/master.key'
append :linked_dirs, 'log', 'tmp'

set :keep_releases, 5
set :migration_role, :app

set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"

set :ruby_version, '2.7.1'
set :rbenv_ruby, '2.7.1'

namespace :deploy do
  desc 'Seed the database using the db: seed rake'
  task seed: [:set_rails_env] do
    on release_roles([:db]) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:seed'
        end
      end
    end
  end

  desc 'Executa rakes'
  task create: [:set_rails_env] do
    on release_roles([:db]) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          # execute :rake, 'db:create' # descomentar caso esteja utilizando banco local
        end
      end
    end
  end

  desc 'Restart Nginx'
  task :nginx_restart do
    on roles(:app) do
      execute 'sudo service nginx restart'
    end
  end

  task :restart do
    invoke! 'unicorn:restart'
  end

  before :compile_assets, :create
  after :migrate, :seed
  after :publishing, :restart
  after :restart, :nginx_restart
end

