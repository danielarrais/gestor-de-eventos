namespace :app do
  desc "Restart server"
  task :restart do
    invoke! 'unicorn:restart'
    invoke! 'nginx:restart'
  end
end
