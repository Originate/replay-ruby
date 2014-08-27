require 'replay_api/event_properties'

module ReplayApi
  class Event < Model

    attribute :event_name, String
    attribute :distinct_id, String
    attribute :properties, EventProperties, default: -> (_, _) { EventProperties.new }

  end
end
