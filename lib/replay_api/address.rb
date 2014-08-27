module ReplayApi
  class Address
    include Virtus.model
    include CompactAttributes

    attribute :street, String
    attribute :city, String
    attribute :state, String
    attribute :country, String
    attribute :zip, String

  end
end
