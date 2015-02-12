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
    attr_accessor :max_request_batch_size
    attr_accessor :max_request_batch_delay

    def initialize
      @replay_server = 'api.replay.io'
      @ssl = true
      @max_request_batch_size = 100
      @max_request_batch_delay = 1
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
