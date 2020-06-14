set :branch, 'develop'
set :server_ip, '191.96.51.176'
set :server_address, 'danielarrais.dev'
set :rails_env,   "production"

ask(:password, nil, echo: false)
server fetch(:server_ip), user: "deploy", roles: %w{app db web}

set :puma_preload_app, true