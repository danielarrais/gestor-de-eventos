# Configura conexão com o Sentry
Raven.configure do |config|
  config.dsn = 'https://ac4ed2a1e4124d70910fd5714726a2b0:018c81943f4d4ab2b6acc3a36c967184@o390258.ingest.sentry.io/5232485'
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
end