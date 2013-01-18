gem 'rspec-rails', :group => :test

post_bundler_strategies << lambda do
  generate 'rspec:install'
end
