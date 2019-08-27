source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.3'
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
gem 'puma', '~> 4.1'
gem 'sass-rails', '~> 6.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bcrypt', '~> 3.1.7'
gem 'mini_magick', '~> 4.9'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'erb2haml'
gem 'haml-rails'
gem 'email_validator', '~> 2.0'
gem 'rails-i18n', '~> 5.1'
gem 'kaminari'
gem 'kaminari-i18n'
gem 'jquery-rails'
gem 'acts_as_list'
gem 'active_hash'
gem 'draper'
gem 'aws-sdk-s3', require: false
gem 'whenever', require: false

group :production do
  gem 'unicorn', '5.5.1'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'
  gem "awesome_print"
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'faker-japanese'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'webdrivers'

  # auto deploy
  gem 'capistrano'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano3-unicorn'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rails-erd'
  gem 'bullet'
  gem 'brakeman', require: false
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
