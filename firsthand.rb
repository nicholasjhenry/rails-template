template_path = File.expand_path(File.dirname(template), File.join(root,'..'))
require File.join(template_path, 'extensions', 'template_runner')

init_template_path(template_path)

# ============================================================================
# GEMS
# ============================================================================

load_pattern 'Gemfile'
load_pattern 'config/preinitializer.rb'
load_pattern 'config/boot.rb'

run "bundle install --without production"

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
ExceptionNotification::Notifier.exception_recipients = %w(webmaster@firsthand.ca)
END

initializer 'date_formats.rb', <<-END
ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS[:friendly] = "%B %Y"
END

initializer 'form_errors.rb', <<-END
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  klass = html_tag.match(/<label.*>/) ? "labelWithErrors" : "fieldWithErrors"
  %Q{<span class="\#{klass}">\#{html_tag}</span>}
end
END


# ============================================================================
# Configuration
# ============================================================================

load_pattern 'lib/my_app.rb'

load_pattern 'config/application.yml'

run "cp config/database.yml config/database.yml.example"

# Compass
run 'compass --rails -f blueprint . --css-dir=public/stylesheets/compiled --sass-dir=app/stylesheets'

# ============================================================================
# Plugins
#
# Use Gitneral to manage external dependencies
# ============================================================================

load_pattern 'config/giternal.yml'

run 'giternal update'

# Use specific branches, tags
run 'cd vendor/plugins/exception_notification && git co 2-3-stable'

run 'giternal freeze'

# ============================================================================
# Testing
# ============================================================================

# Don't need ./test since we are using RSpec
#
run 'rm -rf test doc'

# Rspec will configure the test environment with Gems config, but this is
# handled in bundler so let's backup the file...
#
run 'cp config/environments/test.rb tmp/test.rb.bak'

generate :rspec

# ...and copy it back once rspec has done it's thing
#
run 'mv tmp/test.rb.bak config/environments/test.rb'

generate :cucumber, "--webrat --rspec"

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
puts "SUCCESS!"