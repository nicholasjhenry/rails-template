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
      env << "\n"
      env << string
      File.open(file, 'w') do |env_out|
        env_out.write(env)
      end
    end
    
    def prepend_file(file, string)
      env = IO.read(file)
      string << "\n"
      string << env
      File.open(file, 'w') do |env_out|
        env_out.write(string)
      end
    end
  end
end