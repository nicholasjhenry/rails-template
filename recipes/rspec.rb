gem 'rspec-rails', '~>2.4', :group => [:test, :development, :cucumber]
gem 'shoulda', '~>2.11', :group => :test

post_bundler_strategies << lambda do
  generate 'rspec:install'
end
