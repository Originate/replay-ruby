require 'faraday'
require 'faraday_middleware'
require 'typhoeus'
require 'typhoeus/adapters/faraday'

module ReplayApi
  class Client
    attr_reader :configuration
    attr_accessor :deliverer

    def initialize(configuration=ReplayApi.configuration, deliverer=ReplayApi::RequestDeliverer.instance)
      @configuration ||= configuration
      @deliverer ||= deliverer
    end

    def event(event=Event.new)
      yield event if block_given?
      deliverer.post(uri: '/events', payload: payload(event.compact_attributes))
    end

    def trait(trait=Trait.new)
      yield trait if block_given?
      deliverer.post(uri: '/traits', payload: payload(trait.compact_attributes))
    end

    private

    def payload(data)
      { replay_key: configuration.replay_key }.merge data
    end
  end
end
