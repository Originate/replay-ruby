require 'replay_api/address'

module ReplayApi
  class TraitProperties
    include Virtus.model
    include CompactAttributes

    attribute :address, Address, default: -> (_, _) { Address.new }
    attribute :age, Integer
    attribute :birthday, String
    attribute :avatar, String
    attribute :created_at, Integer
    attribute :description, String
    attribute :email, String
    attribute :employees, Integer
    attribute :first_name, String
    attribute :gender, String
    attribute :industry, String
    attribute :ip, String
    attribute :last_name, String
    attribute :name, String
    attribute :page_name, String
    attribute :page_url, String
    attribute :past_event, Integer, default: 0
    attribute :phone, String
    attribute :timestamp, Integer, default: -> (_, _) { clock.now }
    attribute :title, String
    attribute :username, String

    def self.clock=(val)
      @clock = val
    end

    def self.clock
      @clock ||= Time
    end
  end
end
