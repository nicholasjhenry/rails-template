module MyApp
  class Version
    attr_reader :major, :minor, :tiny
    
    def initialize(major, minor, tiny)
      @major = major
      @minor = minor
      @tiny  = tiny
    end
    
    def ==(version)
      if version.is_a? Version
        version.major == major && version.minor == minor && version.tiny == tiny
      else
        version.to_s == to_s
      end
    end
    
    def to_s
      @string ||= [@major, @minor, @tiny] * '.'
    end
    
    alias_method :inspect, :to_s
  end

  def self.[](key)
    unless @config
      raw_config = File.read(RAILS_ROOT + "/config/application.yml")
      @config = YAML.load(raw_config)[RAILS_ENV].symbolize_keys
    end
    @config[key]
  end

  def self.[]=(key, value)
    @config[key.to_sym] = value
  end
  
  def self.domain
    [:domain]
  end
    
  def self.full_url
    "http://#{domain}"
  end 

  class << self
    attr_accessor :version, :project_name
  end

  self.version        = Version.new(0, 0, 1)
  self.project_name   = "Project Name (update this in lib/my_app.rb)" 

end