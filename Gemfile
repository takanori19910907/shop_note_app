source 'https://rubygems.org'

ruby '2.7.0'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.6'

gem 'devise'

gem 'devise-i18n'

gem 'devise-i18n-views'

gem 'rails-i18n'

gem 'bootstrap', '~> 4.3.1'

gem 'jquery-rails'

gem 'bcrypt', '3.1.12'

gem 'font-awesome-rails'

gem 'kaminari'

gem 'carrierwave'

gem 'rmagick'

gem 'puma', '~> 3.7'

gem 'sass-rails', '~> 5.0'

gem 'uglifier', '>= 1.3.0'

gem 'coffee-rails', '~> 4.2'

gem 'turbolinks', '~> 5'

gem 'jbuilder', '~> 2.5'

group :development, :test do
  gem 'sqlite3', '1.3.13'

  gem 'pry-rails'

  gem 'pry-byebug'

  gem 'pry-doc'

  gem 'selenium-webdriver'

  gem 'rspec-rails'

  gem "factory_bot_rails"
end

group :development do
  gem 'web-console', '>= 3.3.0'

  gem 'listen', '>= 3.0.5', '< 3.2'

  gem 'spring'

  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'bullet'

  gem 'rubocop'

  gem 'rubocop-rails'

  gem 'spring-commands-rspec'
end

group :production do
  gem 'pg', '0.20.0'
end

group :production, :staging do
    gem 'unicorn'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
