#source 'http://rubygems.org'
source 'http://ruby.taobao.org/'
# Bundle edge Rails instead:
ruby '1.9.3'

gem 'rails', '4.1.8'

gem 'mysql2'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

#gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
#group :test, :development do
#  gem "rspec-rails", "~> 2.0"
#  gem "capybara"
#end

gem 'ruby-hmac' #http://ryanbigg.com/2009/07/no-such-file-to-load-hmac-sha1/

gem 'spree', '~>2.4'

# bundle config --local local.spree_simple_dash ../spree_simple_dash, using local for development 
# :path => '../spree_simple_dash' 
# replace Spree Analytics
# gem 'spree_simple_dash', :github=>"RuanShan/spree_simple_dash", :branch=>"1-2-stable"

# referer to https://github.com/spree/spree/issues/2013
gem 'spree_auth_devise', :github => "spree/spree_auth_devise", :branch => "2-4-stable"
#support rich_editor 
gem 'spree_editor',  :github => "spree/spree_editor", :branch=>"2-4-stable"
gem 'tinymce-rails-langs'
#gem 'daemons'
#gem 'delayed_job_active_record'
#'bundle update spree_multi_site' to update gem
# bundle config require specified branch, or warning message as below
# Cannot use local override for spree_multi_site at ../spree_multi_site because :branch is not specified in Gemfile. Specify a branch or use `bundle config --delete` to remove the local override
  
gem 'spree_multi_site',   :path => './spree_multi_site'

gem "friendly_id" # spree_theme require it.
gem 'spree_theme',   :path => './spree_theme'

#only specify it here, then could use ActiveMerchant::Billing::Integrations::Alipay::Helper directly
gem 'offsite_payments'
gem 'activemerchant_patch_for_china', github:'RuanShan/activemerchant_patch_for_china', branch:'for_offsite_payments'
gem 'spree_alipay',   :github => "RuanShan/spree_alipay", :branch=>"master"

gem 'spree_china_checkout',   :path => './spree_china_checkout'

gem 'spree_essential_blog',   :path => './spree_essential_blog'

# copy from https://github.com/RuanShan/spree_flexi_variants/tree/2-1-stable
gem 'spree_flexi_variants',   :path => './spree_flexi_variants'

# copy from https://github.com/spree-contrib/spree_comments/tree/2-0-stable
gem 'spree_comments',   :path => './spree_comments'

group :test, :development do
  gem 'mail_view'  #, :git => 'https://github.com/37signals/mail_view.git'
end

group :test do
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'factory_girl'
  gem 'capybara'
  gem 'capybara-accessible'  
  gem 'webmock'
end
#execjs need js runtime
gem 'therubyracer' 

group :development do
  gem 'capistrano'
  gem 'capistrano-rails', '~> 1.1.0'
  gem 'capistrano-rvm', '~> 0.1.0'
  gem "rails-erd"
end


