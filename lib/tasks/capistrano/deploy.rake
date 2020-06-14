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

  namespace :server do
    desc "Restart server"
    task :restart do
      invoke! 'unicorn:restart'
      on roles(:app) do
        execute 'sudo service nginx restart'
      end
    end

    desc 'Configura servidor'
    task :conf do
      on roles(:app) do
        execute('mkdir -p /var/www/seu/shared/config/')
        upload('config/database.yml', '/var/www/seu/shared/config/database.yml', options = {})
        execute('echo $APP_MASTER_KEY > /var/www/seu/shared/config/master.key')
      end
    end
  end

  before :compile_assets, :create
  after :migrate, :seed
  after :publishing, 'server:restart'
end
