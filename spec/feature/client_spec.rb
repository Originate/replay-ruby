require 'spec_helper'

ReplayApi.configure do |config|
  config.replay_key = 'bogus-key'
  config.ssl = false
end

describe 'Posting Events' do
  let(:client) { ReplayApi::Client.new }

  it 'can post an event' do
    client.event do |event|
      event.event_name = 'Test Event'
    end
  end
end
