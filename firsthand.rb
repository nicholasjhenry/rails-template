template_path = File.expand_path(File.dirname(__FILE__))
require File.join(template_path, 'extensions', 'template_runner')
 
init_template_path(template_path)

required_recipes = %w(autotest choices haml compass custom_error_message meta_tags will_paginate faker factory_girl rspec spork cucumber email_spec jquery)
required_recipes.each {|required_recipe| apply recipe(required_recipe)}

run 'bundle install'

execute_post_bundler_strategies

# ============================================================================
# Application
# ============================================================================

load_pattern 'app/controllers/application_controller.rb'

load_pattern 'app/helpers/application_helper.rb'
 
load_pattern 'app/views/shared/_flashes.html.haml'
 
load_pattern 'app/views/layouts/application.html.haml'
remove_file 'app/views/layouts/application.html.erb'

initializer 'date_formats.rb', <<-END
# Example time formats
{ :short_date => "%x", :long_date => "%a, %b %d, %Y" }.each do |k, v|
  Date::DATE_FORMATS.update(k => v)
end
END

initializer 'form_errors.rb', <<-END
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  klass = html_tag.match(/<label.*>/) ? "labelWithErrors" : "fieldWithErrors"
  %Q{<span class="\#{klass}">\#{html_tag}</span>}.html_safe
end
END

# ============================================================================
# Configuration
# ============================================================================

run "cp config/database.yml config/database.yml.example"

# ============================================================================
# Documentation
# ============================================================================

run 'rm -rf README doc'

load_pattern 'README.textile'

# ============================================================================
# Git Setup
# ============================================================================
                         
remove_file "public/index.html"
run "touch public/stylesheets/screen.css"
run "touch public/stylesheets/print.css" 

file '.gitignore', <<-END
.bundle
.bundle-cache
.DS_Store
.livereload.yml
.sass-cache/
.xrefresh-server.yml
config/database.yml
coverage/*
db/*.sqlite3
db/*.sqlite3.db
doc/api
doc/app
log/*.log
mkmf.log
public/assets
public/system
public/uploads
public/stylesheets/compiled
tmp/**/*
tmp/metric_fu/*
tmp/sent_mails/*
END

run 'find . \( -type d -empty \) -and \( -not -regex ./\.git.* \) -exec touch {}/.gitignore \;'
git :init
git :add => "."
git :commit => "-a -m 'Initial project commit'"

# Success!
puts <<-END
============================================================================
SUCCESS!

To configure Spork:

To use spork run (and then edit spec/spec_helper.rb):
$ spork --bootstrap

# .rspec 
--drb

============================================================================
END
