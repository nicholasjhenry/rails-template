gem 'choices'

insert_into_file 'config/application.rb', :before => "end\nend"do
  <<-RUBY
    # Add settings file for Choices gem
    config.from_file "settings.yml" 
  RUBY
end

load_pattern 'config/settings.yml'
