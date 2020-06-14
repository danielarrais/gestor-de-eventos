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
set :rvm_ruby_version, '2.7.1'

namespace :deploy do
  before :check, 'check:shared_files'
  after :migrate, :rakes
  after :rakes, :seed
  after :publishing, 'app:restart'
  after 'nginx:conf', 'app:restart'
end