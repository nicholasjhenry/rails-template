template_path = File.expand_path(File.dirname(__FILE__))
require File.join(template_path, 'extensions', 'template_runner')

init_template_path(template_path)

recipe_names = ENV['RECIPES']

# Order is important due to some dependencies
recipes = %w(
  development
  error_message
  meta_tags
  readme
  template
  acceptance_testing
  unit_testing
)

# Recipes that we don't want to install in every installation
# optional_recipes = %w(optimization)
optional_recipes = %w()

if recipe_names
  recipe_names.split(",").each do |recipe_name|
    raise %(Recipe "#{recipe_name}" does not exist.) if !(recipes + optional_recipes).include?(recipe_name)
    apply recipe(recipe_name)
  end
else
  recipes.each {|required_recipe| apply recipe(required_recipe)}
end

run 'bundle install'

execute_post_bundler_strategies

if recipe_names
  finalize
  return
end

# ============================================================================
# Application
# ============================================================================

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
# Git Setup
# ============================================================================

git :init
git :add => "."
git :commit => "-a -m 'Initial project commit'"

# Success!
finalize
