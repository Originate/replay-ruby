require 'faraday'
require 'faraday_middleware'
require 'typhoeus'
require 'typhoeus/adapters/faraday'

module ReplayApi
  class Client
    attr_reader :configuration
    attr_writer :connection

    def initialize(configuration=ReplayApi.configuration)
      @configuration ||= configuration
    end

    def event(event=Event.new)
      yield event if block_given?
      connection.post '/events', event.compact_attributes.merge(replay_key: configuration.replay_key)
    end

    def trait(trait=Trait.new)
      yield trait if block_given?
      connection.post '/traits', trait.compact_attributes.merge(replay_key: configuration.replay_key)
    end

    private

    def connection
      @connection ||= Faraday.new(url: "#{protocol}://#{configuration.replay_server}") do |conn|
        conn.request  :json
        conn.response :json
        conn.adapter  :typhoeus
      end
    end

    def protocol
      return 'http' unless configuration.ssl?
      'https'
    end
  end
end
