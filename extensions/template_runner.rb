module Rails
  module Generators
    module Actions

      attr_accessor :post_bundler_strategies

      def init_template_path(template_path)
        @firsthand_template_path = template_path
        @post_bundler_strategies = []
      end

      def execute_post_bundler_strategies
        post_bundler_strategies.each {|strategy| strategy.call }
      end

      def recipe(name)
        File.join @firsthand_template_path, 'recipes', "#{name}.rb"
      end

      def load_pattern(pathname)
        absolute_pathname = File.join(@firsthand_template_path, 'patterns', pathname)
        file(pathname, IO.read(absolute_pathname))
      end
      
    end
  end
end
