#既存のプロジェクトのrubyのバージョンを指定
FROM ruby:2.5.3

#パッケージの取得
RUN apt-get update \
    && apt-get install -y --no-install-recommends\
    nodejs  \
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
