source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0', '>= 6.0.3'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18.4'
# Use Unicorn as the app server
gem 'unicorn', '~> 5.5', '>= 5.5.5'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'

# Gem de autenticação
gem 'devise'

# Gem de paginacao
gem 'kaminari'

# Gem para adicionar formulários nested
gem 'nested_form_fields'

# Gem de autenticação com o Google
gem 'omniauth-google-oauth2'
gem 'dotenv-rails', groups: [:development, :test]

# Gem de autorização
gem 'cancancan'

# Gem de tradução de mensagens para o rails
gem 'rails-i18n'

# Gems de validação
gem "cpf_cnpj"
gem "validators"

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Gem do Sentry
gem "sentry-raven"

gem 'nokogiri', '~> 1.11.0.rc2'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'

  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem "capistrano", require: false
  gem "capistrano-rails", require: false
  gem 'capistrano3-unicorn', require: false
  gem 'capistrano-rbenv', require: false
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 3.32', '>= 3.32.2'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
