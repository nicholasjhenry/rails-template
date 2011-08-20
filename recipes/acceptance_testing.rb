gem 'cucumber-rails', '0.4.1', :group => [:test, :development]
gem "capybara", '~>0.4', :group => [:test, :development]

gem "database_cleaner", '~>0.6', :group => [:test, :development]
gem "launchy", :group => [:test, :development]

post_bundler_strategies << lambda do
  generate 'cucumber:install', '--capybara --rspec --spork'
end
