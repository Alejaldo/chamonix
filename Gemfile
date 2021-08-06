source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails', '~> 6.1.3', '>= 6.1.3.1'
gem 'puma', '~> 5.0'
gem 'webpacker', '~> 5.0'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'uglifier'
gem 'devise'
gem 'devise-i18n'
gem 'russian'
gem 'rails-i18n', '~> 6.0.0'
gem 'carrierwave', '~> 2.0'
gem 'rmagick'
gem 'fog-aws'
gem 'dotenv-rails'
gem 'mailjet'
gem 'pundit'
gem 'resque'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-vkontakte'
gem 'omniauth-rails_csrf_protection'

group :development, :test do
  gem 'byebug'
  gem 'sqlite3', '~> 1.4'
  gem 'capybara', '>= 3.26'
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'launchy'
  gem 'rubocop', require: false
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'letter_opener'

  gem 'capistrano', '~> 3.16', require: false
  gem 'capistrano-rails', '~> 1.6', require: false
  gem 'capistrano-passenger', '~> 0.2', require: false
  gem 'capistrano-rbenv', '~> 2.2', require: false
  gem 'capistrano-bundler', '~> 2.0', require: false
  gem 'capistrano-resque', require: false
  gem 'capistrano-rails-console', require: false
end

group :test do
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

group :production do
  gem 'pg'
end
