module Rails
  class TemplateRunner
    def init_template_path(template_path)
      @firsthand_template_path = template_path
    end
    def load_pattern(pathname)
      absolute_pathname = File.join(@firsthand_template_path, 'patterns', pathname)
      file(pathname, IO.read(absolute_pathname))
    end    
  end  
end