# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

ruby '2.7.0'

gem 'activesupport', '~> 6.0', require: false
gem 'pdfmonkey', '~> 0.4.0'
gem 'puma', '~> 4.3'
gem 'rollbar', '~> 2.23', require: 'rollbar/middleware/sinatra'
gem 'sinatra-contrib', '~> 2.0', require: false
gem 'sinatra', '~> 2.0'

group :development do
  gem 'dotenv', '~> 2.7', require: 'dotenv/load'
end
