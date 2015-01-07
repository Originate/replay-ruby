require 'spec_helper'

module ReplayApi
  describe EventProperties do
    subject(:properties) { EventProperties.new }

    describe '#event_category' do
      specify { expect(properties.event_category).to eq 'general' }
    end

    describe '#past_event' do
      specify { expect(properties.past_event).to eq 0 }
    end
  end
end
