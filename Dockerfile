FROM ruby:2.7.0

# Define o ambiente de produção
ENV RAILS_ENV production

# Substitui shell por bash para que possamos obter arquivos de origem
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN mkdir -p /app
RUN mkdir -p /usr/local/nvm

# Define pasta de trabalho
WORKDIR /app

# Instala o NODE.js
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs

# Copia arquivos de depdências para o container
COPY Gemfile Gemfile.lock package.json yarn.lock ./

# Instala o bundler
RUN gem install bundler -v 2.1.2

# Instala as depedências
RUN bundle install --verbose --jobs 20 --retry 5

# Intala o YARN
RUN npm install -g yarn

COPY . ./

# Expõe a porta 80
EXPOSE 80

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]