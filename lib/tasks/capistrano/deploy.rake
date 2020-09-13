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

  desc 'Executa rakes diversas'
  task :rakes do
    on release_roles [:db] do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'seeder:key_situations'
        end
      end
    end
  end

  namespace :check do
    desc 'Create folders and send necessary files'
    task :shared_files do
      on roles(:app) do
        execute 'mkdir -p /var/www/seu/shared/config/'
        execute 'mkdir -p /var/www/seu/shared/tmp/pids/'
        execute 'mkdir -p /var/www/seu/shared/tmp/sockets/'

        upload! 'config/database.yml', '/var/www/seu/shared/config/database.yml'
        execute 'echo $APP_MASTER_KEY | tee /var/www/seu/shared/config/master.key &>/dev/null'
      end
    end
  end
end
