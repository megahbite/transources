source 'https://rubygems.org'
ruby '2.0.0'
gem 'rails', '4.0.2'

gem 'sass-rails',   '~> 4.0.1'
gem 'coffee-rails', '~> 4.0.1'
gem 'uglifier', '>= 1.0.3'

gem 'jquery-rails'
gem 'bootstrap-sass', '>= 3.0.0.0'
gem 'pundit'
gem 'devise'
gem 'haml-rails'
gem 'pg'
gem 'rolify', "~> 3.3.0.rc5", github: 'EppO/rolify'
gem 'sendgrid'
gem 'simple_form'
gem 'country_select'

gem 'acts-as-taggable-on'

gem 'activerecord-postgis-adapter'

gem 'select2-rails'

group :production do
  gem 'passenger'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :rbx]
  gem 'html2haml'
  gem 'quiet_assets'
  gem 'awesome_print'
  gem 'wirble'
  gem 'hirb'

  # Use Capistrano for deployment
  gem 'capistrano', '~> 3.1.0'
  gem 'capistrano-rails', '~> 1.1'
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'faker'
  gem 'shoulda'

  gem "debugger", :platforms => [:mingw_19, :ruby_19]
  gem 'byebug', :platforms => [:mingw_20, :ruby_20]
  gem 'pry-byebug', :platforms => [:mingw_20, :ruby_20]
  gem 'pry-stack_explorer', :platforms => [:mingw_20, :ruby_20]
end
group :test do
  gem 'capybara'
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
  gem 'rake'
end
