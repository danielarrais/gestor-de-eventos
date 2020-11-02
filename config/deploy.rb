# config valid for current version and patch releases of Capistrano
lock '~> 3.14.1'

# Nome da aplicação
set :application, 'gestor-de-eventos'

# URL do repositório
set :repo_url, 'git@gitlab.com:danielarrais/gestor-de-eventos.git'

# Pasta onde ficará a aplicação no servidor
set :deploy_to, '/var/www/gestor-de-eventos'

append :linked_files, 'config/database.yml', 'config/master.key'
append :linked_dirs, 'log', 'tmp'

# Quantidade de versões que devem ser mantidas no servidor
set :keep_releases, 5
set :migration_role, :app

# Localização do arquivo com o PID do servidor em execução
set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"

# Versão do RUBY
set :ruby_version, '2.7.1'
set :rvm_ruby_version, '2.7.1'


namespace :deploy do
  before :check, 'check:shared_files'
  after :migrate, :rakes
  after :rakes, :seed
  after :publishing, 'app:restart'
  after 'nginx:conf', 'app:restart'
end
