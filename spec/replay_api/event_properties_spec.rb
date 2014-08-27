require 'spec_helper'

module ReplayApi
  describe EventProperties do
    subject(:properties) { EventProperties.new }
    let(:clock) { double :clock, now: Time.now }
    before { EventProperties.clock = clock }
    after { EventProperties.clock = nil }

    describe '#event_category' do
      specify { expect(properties.event_category).to eq 'general' }
    end

    describe '#past_event' do
      specify { expect(properties.past_event).to eq 0 }
    end

    describe '#timestamp' do
      specify { expect(properties.timestamp).to eq clock.now.to_i }
    end
  end
end
