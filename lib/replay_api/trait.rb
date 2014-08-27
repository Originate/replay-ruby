require 'replay_api/trait_properties'

module ReplayApi
  class Trait
    include Virtus.model
    include CompactAttributes

    attribute :distinct_id, String
    attribute :properties, TraitProperties, default: -> (_, _) { TraitProperties.new }

  end
end
