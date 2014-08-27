require 'spec_helper'

module ReplayApi
  describe Event do
    subject(:event) { Event.new }

    describe '#properties' do
      specify { expect(event.properties).to be_a(ReplayApi::EventProperties) }
    end
  end
end
