# http://chrismdp.github.com/2010/11/getting-spork-working-now-on-rails-3-rspec-2-and-cucumber/
gem 'spork', :git => "git://github.com/chrismdp/spork.git", :group => [:test, :cucumber]

message = <<-END
To configure Spork:

To use spork run (and then edit spec/spec_helper.rb):
$ spork --bootstrap

# .rspec 
--drb
END

success_notice << message
