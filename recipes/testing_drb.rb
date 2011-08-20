# http://chrismdp.github.com/2010/11/getting-spork-working-now-on-rails-3-rspec-2-and-cucumber/
gem 'spork', '0.9.0.rc', :group => [:test, :cucumber]

message = <<-END
To configure Spork:

To use spork run (and then edit spec/spec_helper.rb):
$ spork --bootstrap

# .rspec
--drb
END

success_notice << message
