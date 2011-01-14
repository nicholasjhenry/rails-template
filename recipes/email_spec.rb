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
