module ReplayApi
  class EventProperties < Model

    attribute :amount, Float
    attribute :app_version, String
    attribute :client_os, String
    attribute :client_sdk, String
    attribute :country, String
    attribute :device_brand, String
    attribute :device_carrier, String
    attribute :device_id, String
    attribute :device_manufacturer, String
    attribute :device_model, String
    attribute :device_type, String
    attribute :event_category, String, default: 'general'
    attribute :ip, String
    attribute :language, String
    attribute :latitude, String
    attribute :longitude, String
    attribute :page_name, String
    attribute :page_url, String
    attribute :past_event, Integer, default: 0

  end
end
