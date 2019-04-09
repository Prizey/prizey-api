# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3' # or newest one

gem 'awesome_print'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'committee', '~> 3.0.0'
gem 'devise-i18n', '~>  1.7.0'
gem 'devise_token_auth', '~> 1.0.0'
gem 'json_schema', '0.20.3' # DO NOT UPDATE THIS
gem 'pg', '>= 0.18', '< 2.0'
gem 'prmd', '~> 0.13'
gem 'puma', '~> 3.11'
gem 'rack-cors', require: 'rack/cors'
gem 'rails', '~> 5.2.2'
gem 'rails-i18n', '~> 5.1.3'
gem 'shopify_api', '~> 7.0.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails', '~> 2.5.0'
  gem 'factory_bot_rails', '~> 5.0.1'
  gem 'rspec-rails', '~> 3.7'
  gem 'rspec_junit_formatter', '~> 0.4.1'
  gem 'rubocop', '~> 0.58.2', require: false
  gem 'rubocop-rspec', '~> 1.27.0', require: false
  gem 'shoulda-matchers', github: 'thoughtbot/shoulda-matchers',
                          branch: 'rails-5'
  gem 'webmock', '~> 3.4.2'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'simplecov', '~> 0.16.1', require: false
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
