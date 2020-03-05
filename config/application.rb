require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Cert
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.i18n.default_locale = 'pt-BR'
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**/*.{rb,yml}').to_s]

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
        :user_name => '26cb2d6ea451fd',
        :password => '9bc0df1629946e',
        :address => 'smtp.mailtrap.io',
        :domain => 'smtp.mailtrap.io',
        :port => '2525',
        :authentication => :cram_md5
    }

    config.to_prepare do
      Devise::Mailer.layout 'mailer' # simple.haml or simple.erb
    end

    config.exceptions_app = self.routes
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
