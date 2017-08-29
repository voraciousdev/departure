require 'yaml'

class Configuration
  CONFIG_PATH = 'config.yml.erb'

  attr_reader :config

  def initialize
    @config = YAML.load(ERB.new(File.read(CONFIG_PATH)).result).freeze
  end

  def [](key)
    config[key]
  end
end
