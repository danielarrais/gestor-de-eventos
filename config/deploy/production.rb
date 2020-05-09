set :branch, 'develop'
set :server_address, '167.172.150.180'

ask(:password, nil, echo: false)
server fetch(:server_address), user: "root", roles: %w{app db web}

set :nginx_server_name, fetch(:server_address)
set :puma_preload_app, true