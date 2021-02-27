# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7q'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', '< 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  # gem 'chromedriver-helper'
  gem 'webdrivers', '~> 3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data'

# 本番環境のデータベース設定
group :production do
  gem 'pg', '>= 0.18', '< 2.0'
end

# jqueryの使用
gem 'jquery-rails'
# ページネーションの使用
gem 'kaminari'
# サインイン、サインアウト等の認証のgem
gem 'carrierwave'
gem "piet"
gem 'cloudinary'
gem 'mini_magick'

gem 'geocoder'

gem 'dotenv-rails'

gem 'gon'

gem 'rails_12factor', group: :production

gem 'rspec_junit_formatter'

gem 'factory_bot_rails'
gem 'rails-controller-testing'
gem 'rspec-rails'

gem 'rails-i18n'

gem 'simple_calendar'

group :development, :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers'
end

gem 'pry-rails'

gem 'rubocop', require: false
gem 'rubocop-rails', require: false

gem 'carrierwave-i18n'
gem 'ransack'

group :development, :test do
  gem 'rails-erd'
end

gem 'rinku'

gem 'react-rails'
gem 'webpacker'

group :development do
  gem 'bullet'
end
