module Rails
  module Generators
    module Actions

      attr_accessor :post_bundler_strategies, :success_notice

      def init_template_path(template_path)
        @firsthand_template_path = template_path
        @post_bundler_strategies = []
        @success_notice = []
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

      def finalize
        puts <<-END
        ============================================================================
        SUCCESS!
        END

        puts success_notice

        puts <<-END
        ============================================================================
        END
      end
    end
  end
end
