gem 'haml-rails', '~>0.3'

load_pattern 'app/helpers/application_helper.rb'
load_pattern 'app/views/shared/_flashes.html.haml'
load_pattern 'app/views/layouts/application.html.haml'
remove_file 'app/views/layouts/application.html.erb'
