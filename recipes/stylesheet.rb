gem 'compass', '~>0.11'

post_bundler_strategies << lambda do
  run 'compass init rails --using blueprint/semantic --css-dir=public/stylesheets/compiled --sass-dir=app/stylesheets --syntax sass'
end
