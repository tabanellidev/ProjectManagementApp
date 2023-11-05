# Dockerfile development version
FROM ruby:3.0.2 AS ProjectManagementApp

# Install yarn on dockerimage
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && apt-key add /root/yarn-pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y --no-install-recommends nodejs yarn

# Default directory
# path container
ENV INSTALL_PATH /opt/app
RUN mkdir -p $INSTALL_PATH

# Install gems 17 - rimuove la cartella node modules e vendor perchè sono cartelle enormi che non metti all'interno dell'immagine
WORKDIR $INSTALL_PATH
COPY ProjectManagementApp/ .
RUN rm -rf node_modules vendor
RUN gem install rails bundler
RUN bundle install
RUN yarn install

EXPOSE 3000

# Start server
CMD rails server