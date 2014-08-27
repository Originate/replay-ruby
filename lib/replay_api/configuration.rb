module ReplayApi
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield configuration
  end

  class Configuration
    attr_accessor :replay_key
    attr_accessor :replay_server
    attr_accessor :ssl

    def initialize
      @replay_server = 'api.replay.io'
      @ssl = true
    end

    alias_method :ssl?, :ssl

    def extend_event_properties(&block)
      yield EventPropertiesExtensions
      ReplayApi::EventProperties.include EventPropertiesExtensions
    end

    def extend_trait_properties(&block)
      yield TraitPropertiesExtensions
      ReplayApi::TraitProperties.include TraitPropertiesExtensions
    end
  end
end
