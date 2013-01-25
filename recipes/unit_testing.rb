gem 'rspec-rails', :group => [:development, :test]

post_bundler_strategies << lambda do
  generate 'rspec:install'
end
