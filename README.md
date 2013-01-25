## Template Description

* Adds useful development Gems
* RSpec for unit testing and Cucumber for acceptance testing.
* Compass and Haml for templating.
* Adds a file layout for stylesheets
* Add a nice template for README with placeholders

See the recipes directory for more details.

## Setup/Installation

    $ rails new myproject -m /path/to/firsthand.rb

## Next Steps

Then give it a whirl:

    $ cd myproject
    $ rake db:create
    $ rails g scaffold post title:string body:text
    $ rake db:migrate
    $ script/server

Visit:

    http://localhost:3000/posts

You can also run the generated spec using <tt>rake spec</tt>.

## Running a Single Recipe

You can also run a single or multiple recipes in an existing application by passing in the names:

rake rails:template LOCATION=/path/to/firsthand.rb RECIPES=stylesheet,template

In this case, this will only run the stylesheet and template recipes. You will be required to commit changes to source control yourself after the recipe has been run. What recipes can be run? See <tt>./recipes</tt>.

h1. Credits

Some concepts borrowed from:
http://github.com/ffmike/BigOldRailsTemplate
https://github.com/kfaustino/rails-templater
