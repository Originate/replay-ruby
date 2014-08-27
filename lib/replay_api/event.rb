require 'replay_api/event_properties'

module ReplayApi
  class Event
    include Virtus.model
    include CompactAttributes

    attribute :event_name, String
    attribute :distinct_id, String
    attribute :properties, EventProperties, default: -> (_, _) { EventProperties.new }

  end
end
