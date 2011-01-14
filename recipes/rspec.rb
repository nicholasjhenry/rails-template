gem 'rspec-rails', '~>2.4', :group => [:test, :development, :cucumber]
gem 'rspec', '~>2.4', :group => :test
gem 'shoulda', '~>2.11', :group => :test

post_bundler_strategies << lambda do
  remove_dir 'test'
  generate 'rspec:install'
end
