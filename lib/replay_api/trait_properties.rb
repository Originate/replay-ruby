require 'replay_api/address'

module ReplayApi
  class TraitProperties < Model

    attribute :address, Address, default: -> (_, _) { Address.new }
    attribute :age, Integer
    attribute :avatar, String
    attribute :birthday, String
    attribute :company, String
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

  end
end
