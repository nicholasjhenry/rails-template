gem 'haml-rails'

load_pattern 'app/helpers/application_helper.rb'
load_pattern 'app/views/application/_flashes.html.haml'
load_pattern 'app/views/layouts/application.html.haml'
remove_file 'app/views/layouts/application.html.erb'
