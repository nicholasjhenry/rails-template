gem 'jquery-rails'

post_bundler_strategies << lambda do
  generate 'jquery:install', '--ui'
end
