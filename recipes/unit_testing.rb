gem 'autotest-rails'

gem 'faker'

gem 'shoulda', '~>2.11', :group => :test

gem 'factory_girl_rails', :group => [:test, :cucumber]

gem 'rspec-rails', '~>2.4', :group => [:test, :development, :cucumber]

post_bundler_strategies << lambda do
  generate 'rspec:install'
end

gem 'fuubar'

success_notice << <<-END
Fuubar: add the following to .rspec

--format Fuubar
END

gem 'boure', '~>1.0', :group => :test

success_notice << <<-END
Bourne: add the following to spec/spec_helper

config.mock_with :mocha
END

gem 'cover_me', '>= 1.0.0.rc5', :group => :test

gem 'email_spec', '~>1.1', :group => [:test, :cucumber]

post_bundler_strategies << lambda do
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

  insert_into_file "spec/spec_helper.rb", :before => "end" do
    <<-RUBY

    config.include(EmailSpec::Helpers)
    config.include(EmailSpec::Matchers)
    RUBY
  end
end
