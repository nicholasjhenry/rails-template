gem 'cucumber-rails', :group => :test
gem 'capybara', :group => :test

gem 'database_cleaner', :group => :test
gem 'launchy', :group => :test

post_bundler_strategies << lambda do
  generate 'cucumber:install'
end
