namespace :deploy do
  desc 'Seed the database using the db: seed rake'
  task seed: [:set_rails_env] do
    on release_roles [:db] do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:seed'
        end
      end
    end
  end

  desc "Restart server"
  task :restart do
    invoke! 'unicorn:restart'
    on roles :app do
      execute 'sudo service nginx restart'
    end
  end

  desc 'Configura servidor'
  task :nginx_conf do
    on roles(:app) do
      execute 'mkdir -p /var/www/seu/shared/config/'
      upload! 'config/database.yml', '/var/www/seu/shared/config/database.yml'
      execute 'source /etc/profile && echo $APP_MASTER_KEY | tee /var/www/seu/shared/config/master.key &>/dev/null'
    end
  end

  desc 'Configura servidor'
  task :rakes do
    on release_roles [:db] do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'seeder:key_situations'
        end
      end
    end
  end

  desc 'Configura servidor'
  task :upload_files do
    on roles(:app) do
      execute 'mkdir -p /var/www/seu/shared/config/'
      execute 'mkdir -p /var/www/seu/shared/tmp/pids/'
      execute 'mkdir -p /var/www/seu/shared/tmp/sockets/'
      upload! 'config/database.yml', '/var/www/seu/shared/config/database.yml'
      execute 'echo $APP_MASTER_KEY | tee /var/www/seu/shared/config/master.key &>/dev/null'
    end
  end
end