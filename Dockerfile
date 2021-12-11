FROM ruby:3.0.3

ENV NODE_VERSION=12.14.1

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client && apt-get install -y imagemagick --fix-missing

WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

RUN curl -sSL "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" | tar xfJ - -C /usr/local --strip-components=1 && \
  npm install npm -g
RUN npm install -g yarn

RUN bundle install
RUN yarn install
COPY . /myapp


COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
