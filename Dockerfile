# Dockerfile development version
FROM ruby:3.0.2 AS ProjectManagementApp

# Install yarn on dockerimage
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && apt-key add /root/yarn-pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y --no-install-recommends nodejs yarn
RUN apt-get update && apt-get -y install cron

# Default directory
# path container
ENV INSTALL_PATH /opt/app
RUN mkdir -p $INSTALL_PATH

# Install gems
WORKDIR $INSTALL_PATH
COPY ProjectManagementApp/ .
RUN rm -rf node_modules vendor
RUN gem install rails bundler
RUN bundle install
RUN yarn install


RUN rails db:reset
#RUN cd ProjectManagementApp

EXPOSE 3000

#Start cronjob
RUN bundle exec whenever 

RUN whenever --update-crontab --set environment=development

RUN crontab -l

# Start server
CMD ["rails", "server", "-b", "0.0.0.0"]