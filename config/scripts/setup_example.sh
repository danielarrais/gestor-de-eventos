#!/usr/bin/env bash

install_pg="false"
conf_cert_bot="true"
conf_nginx="true"

ruby_version="2.7.1"
cert_enviroments_sh="/etc/profile.d/cert-enviroments.sh"

# Google API credentials
google_client_id=""
google_app_token=""

# App Parameters
secret_key_base=""
database_user=""
database_password=""
database_host=""
database_name=""
app_master_key=""

# SSL Parameters
server_name=""
email_address=""

echo "Set enviroments variables"
{
  touch $cert_enviroments_sh

  echo "export GOOGLE_CLIENT_ID=\"$google_client_id\"" >$cert_enviroments_sh
  echo "export GOOGLE_APP_TOKEN=\"$google_app_token\"" >$cert_enviroments_sh
  echo "export SECRET_KEY_BASE=\"$secret_key_base\"" >$cert_enviroments_sh
  echo "export APP_MASTER_KEY=\"$app_master_key\"" >$cert_enviroments_sh
  echo "export DATABASE_USER=\"$database_user\"" >$cert_enviroments_sh
  echo "export DATABASE_PASSWORD=\"$database_password\"" >$cert_enviroments_sh
  echo "export DATABASE_HOST=\"$database_host\"" >$cert_enviroments_sh
  echo "export DATABASE_NAME=\"$database_name\"" >$cert_enviroments_sh

  source $cert_enviroments_sh
} &>/dev/null

echo "Installing git"
sudo apt install git -y &>/dev/null

echo "Installing RVM Dependencies"
{
  sudo apt install curl -y
  curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

  sudo apt update
  sudo apt install git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs yarn -y
} &>/dev/null

echo "Installing RVM"
{
  sudo apt install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev -y
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
  curl -sSL https://get.rvm.io | bash -s stable

  echo '' >>"$HOME"/.zshrc
  echo "[[ -s '$HOME/.rvm/scripts/rvm' ]] && . '$HOME/.rvm/scripts/rvm'" >>"$HOME"/.zshrc

  echo '' >>"$HOME"/.bashrc
  echo "[[ -s '$HOME/.rvm/scripts/rvm' ]] && . '$HOME/.rvm/scripts/rvm'" >>"$HOME"/.bashrc
} &>/dev/null

echo "Installing Ruby $ruby_version"
{
  rvm install $ruby_version
  rvm use $ruby_version --default
  ruby -v
} &>/dev/null

echo "Installing Bundle"
gem install bundler &>/dev/null

echo "Installing GEM Postgres dependence"
sudo apt install libpq-dev -y &>/dev/null

if [[ $install_pg == "true" ]]; then
  echo "Installing Postgres"
  {
    sudo apt install postgresql postgresql-contrib -y
    su - postgres -c "psql -U postgres -d postgres -c \"alter user postgres with password '$database_password';\""
  } &>/dev/null
fi

if [[ $conf_nginx == "true" ]]; then
  echo "Installing Nginx"
  {
    sudo apt install nginx -y
  } &>/dev/null
fi

if [[ $conf_cert_bot == "true" ]]; then
  echo "Configuring certificate SSL"
  {
    sudo apt install python-certbot-nginx
    sudo certbot --nginx -d $server_name -d www.$server_name --non-interactive --agree-tos -m $email_address
  } &>/dev/null
fi