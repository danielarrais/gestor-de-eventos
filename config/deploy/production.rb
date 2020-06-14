set :branch, 'develop'
set :server_address, '191.96.51.176'
set :rails_env,   "production"

ask(:password, nil, echo: false)
server fetch(:server_address), user: "deploy", roles: %w{app db web}

set :puma_preload_app, true