template_path = File.expand_path(File.dirname(__FILE__))
require File.join(template_path, 'extensions', 'template_runner')
 
init_template_path(template_path)

# ============================================================================
# GEMS
# ============================================================================

load_pattern 'Gemfile'

run "bundle install --without production"

# ============================================================================
# Application
# ============================================================================

load_pattern 'app/controllers/application_controller.rb'

load_pattern 'app/helpers/application_helper.rb'
 
load_pattern 'app/views/shared/_flashes.html.haml'
 
load_pattern 'app/views/layouts/application.html.haml'
run 'rm -f app/views/layouts/application.html.erb'

generate 'jquery:install', '--ui'

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
# Choices (application settings)
# ============================================================================

insert_into_file 'config/application.rb', :before => "end\nend"do
  <<-RUBY
    # Add settings file for Choices gem
    config.from_file "settings.yml" 
  RUBY
end

load_pattern 'config/settings.yml'

# ============================================================================
# Configuration
# ============================================================================

load_pattern 'config/application.yml'

run "cp config/database.yml config/database.yml.example"

# Compass
run 'compass init rails --using blueprint/semantic --css-dir=public/stylesheets/compiled --sass-dir=app/stylesheets --syntax sass'

# ============================================================================
# Testing
# ============================================================================

# Don't need ./test since we are using RSpec
#
run 'rm -rf test'
generate 'rspec:install'
generate 'cucumber:install', '--capybara --rspec --spork'
generate 'email_spec:steps'

# configure email_sepc for Cucumber

insert_into_file "features/support/env.rb", :after => "require 'cucumber/rails/world'\n" do
  <<-RUBY
  require 'email_spec'
  require 'email_spec/cucumber'
  RUBY
end

# configure email_spec for Rspec

insert_into_file "spec/spec_helper.rb", "require 'email_spec'", :after => "require 'rspec/rails'\n"

insert_to_file "spec/spec_helper.rb", :before => "end" do
  <<-RUBY

  config.include(EmailSpec::Helpers)
  config.include(EmailSpec::Matchers)
  RUBY
end

# ============================================================================
# Documentation
# ============================================================================

run 'rm -rf README doc'

load_pattern 'README.textile'

# ============================================================================
# Git Setup
# ============================================================================
                         
run "rm public/index.html"
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

# spec/spec.opts
--drb

============================================================================
END
