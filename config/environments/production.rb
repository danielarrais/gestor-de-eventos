Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.public_file_server.enabled = true
  config.assets.compile = false
  config.active_storage.service = :local
  config.log_level = :debug
  config.log_tags = [ :request_id ]
  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  # configure sentry connection
  Raven.configure do |config|
    config.dsn = 'https://ac4ed2a1e4124d70910fd5714726a2b0:018c81943f4d4ab2b6acc3a36c967184@o390258.ingest.sentry.io/5232485'
    config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
  end

  config.active_record.dump_schema_after_migration = false
end
