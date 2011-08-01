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
        File.directory?(File.join(pattern_path, pathname)) ? write_directory_pattern(pathname) :
                                    write_file_pattern(pathname)
      end

      def finalize
        puts <<-END
        ============================================================================
        SUCCESS!
        END

        success_notice.each do |notice|
          puts notice
          puts ""
        end

        puts <<-END
        ============================================================================
        END
      end

      private

      def write_directory_pattern(directory_pathname)
        pathnames = Dir.glob(File.join(pattern_path, directory_pathname, '**', '*'))
        pathnames.each do |source_pathname|
          destination_pathname = source_pathname.sub(pattern_path + '/', '')
          file(destination_pathname, IO.read(source_pathname)) unless File.directory?(source_pathname)
        end
      end

      def write_file_pattern(destination_pathname)
        source_pathname = File.join(pattern_path, destination_pathname)
        file(destination_pathname, IO.read(source_pathname))
      end
      
      def pattern_path
        File.join(@firsthand_template_path, 'patterns')
      end
    end
  end
end
