#既存のプロジェクトのrubyのバージョンを指定
FROM ruby:2.5.3

#パッケージの取得
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash \
    && curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    # nodejs \
    && apt-get update \
    && apt-get install -y --no-install-recommends\
    && apt-get install -y nodejs \
    yarn \
    mariadb-client  \
    build-essential  \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
    
WORKDIR /Wediary

COPY Gemfile /Wediary/Gemfile
COPY Gemfile.lock /Wediary/Gemfile.lock

RUN gem install bundler
RUN bundle install

#既存railsプロジェクトをコンテナ内にコピー
COPY . /Wediary
