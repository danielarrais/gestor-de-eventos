require 'liquid'

namespace :nginx do
  desc 'Configure nginx'
  task :conf do
    on roles(:app) do
      nginx_conf = Liquid::Template.parse(File.read("lib/templates/nginx/nginx.conf.liquid"))
      nginx_conf = nginx_conf.render('site_address' => fetch(:server_address))

      file = File.new('tmp/nginx.conf', "w")
      file.write(nginx_conf)
      file.close

      upload! 'tmp/nginx.conf', '/etc/nginx/sites-enabled/default'

      File.delete(file)
    end
  end

  desc "Restart nginx"
  task :restart do
    on roles :app do
      execute 'sudo service nginx restart'
    end
  end
end
