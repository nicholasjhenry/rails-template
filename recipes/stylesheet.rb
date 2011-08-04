gem 'compass', '~>0.11'

post_bundler_strategies << lambda do
  run 'compass init rails --using blueprint/semantic --css-dir=public/stylesheets/compiled --sass-dir=app/stylesheets --syntax sass'
end

message = <<-END
If you are deploy Heroku, add tmp to the css_dir in config/compass.rb:

css_dir = "tmp/public/stylesheets/compiled"
END

success_notice << message
