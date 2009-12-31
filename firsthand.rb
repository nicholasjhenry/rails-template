template_path = File.expand_path(File.dirname(template), File.join(root,'..'))
require File.join(template_path, 'extensions', 'template_runner')

init_template_path(template_path)

# ============================================================================
# GEMS
# ============================================================================

gem 'RedCloth', :lib => 'redcloth', :version => '~> 3.0.4'
gem 'haml'
gem 'compass'
gem 'will_paginate'

# development
gem "inaction_mailer", :lib => 'inaction_mailer/force_load', :env => 'development'

# testing
gem 'mocha'
gem 'factory_girl'
gem 'shoulda'
gem 'quietbacktrace'
gem 'metric_fu'
gem 'tarantula', :lib => 'relevance/tarantula'

rake("gems:install", :sudo => true)
rake("gems:unpack")

# ============================================================================
# Application
# ============================================================================

load_pattern 'app/controllers/application_controller.rb'

load_pattern 'app/helpers/application_helper.rb'
 
load_pattern 'app/views/shared/_flashes.html.haml'
 
load_pattern 'app/views/layouts/application.html.haml'

initializer 'time_formats.rb', <<-END
# Example time formats
{ :short_date => "%x", :long_date => "%a, %b %d, %Y" }.each do |k, v|
  ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.update(k => v)
end
END

initializer 'exception_notifier.rb', <<-END
ExceptionNotifier.exception_recipients = %w(webmaster@firsthand.ca)
END

initializer 'form_errors.rb', <<-END
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  klass = html_tag.match(/<label.*>/) ? "labelWithErrors" : "fieldWithErrors"
  "<span class=\"#{klass}\">#{html_tag}</span>"
end
END


# ============================================================================
# Configuration
# ============================================================================

capify!

load_pattern 'test/test_helper.rb'

load_pattern 'lib/my_app.rb'

run "cp config/database.yml config/database.yml.example"

# Compass
run 'haml --rails .'
run 'compass --rails -f blueprint . --css-dir=public/stylesheets/compiled --sass-dir=app/stylesheets'

# ============================================================================
# Git Setup
# ============================================================================
                         
# Use Gitneral to manage external dependencies
load_pattern 'config/giternal.yml'

run 'giternal update'
run 'giternal freeze'
 
run "rm public/index.html"
run "touch public/stylesheets/screen.css"
run "touch public/stylesheets/print.css" 

file '.gitignore', <<-END
.DS_Store
config/database.yml
coverage/*
db/*.sqlite3
doc/api
doc/app
log/*.log
tmp/**/*
tmp/metric_fu/*
tmp/sent_mails/*
END

run 'find . \( -type d -empty \) -and \( -not -regex ./\.git.* \) -exec touch {}/.gitignore \;'
git :init
git :add => "."
git :commit => "-a -m 'Initial project commit'"

# Success!
puts "SUCCESS!"