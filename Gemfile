#source 'http://mirror1.prod.rhcloud.com/mirror/ruby/'
source 'https://rubygems.org'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2'
gem 'sqlite3'

# Gems used only for assets and not required
# in production environments by default.
group :assets do

  # required for compiling the less stuff (bootstrap)
  gem 'libv8', '~> 3.11.8'

  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby
  gem 'less-rails-bootstrap'

  gem 'uglifier', '>= 1.0.3'
  gem 'jquery-ui-rails'
end

gem 'jquery-rails'


# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

# This version needs to be hardcoded for OpenShift compatability
gem 'thor', '= 0.14.6'

# This needs to be installed so we can run Rails console on OpenShift directly
gem 'minitest'
gem 'ruby-prof'
gem 'bcrypt-ruby', '~> 3.0.0', :require => "bcrypt"
gem "ember-rails"
gem "rabl"
gem "mongodb", "~> 2.1.0"
gem "bson_ext"

group :test do
  gem "mocha", '=0.13.1', :require => false
  gem 'shoulda'
end
