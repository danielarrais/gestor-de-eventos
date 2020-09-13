FROM ruby:2.7.1

# Define o ambiente de produção
ENV RAILS_ENV production

# Substitui shell por bash para que possamos obter arquivos de origem
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Cria a pasta onde ficará os arquivos da aplicação
RUN mkdir -p /app

# Define pasta da aplicação como pasta de trabalho
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

# Expõe a porta 80
EXPOSE 80

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]