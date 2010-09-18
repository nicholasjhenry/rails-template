module Rails
  class TemplateRunner
    def init_template_path(template_path)
      @firsthand_template_path = template_path
    end
    def load_pattern(pathname)
      absolute_pathname = File.join(@firsthand_template_path, 'patterns', pathname)
      file(pathname, IO.read(absolute_pathname))
    end
    
    def append_file(file, string)
      env = IO.read(file)
      env << string
      File.open(file, 'w') do |env_out|
        env_out.write(env)
      end
    end
  end
end