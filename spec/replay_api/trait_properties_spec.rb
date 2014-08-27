require 'spec_helper'

module ReplayApi
  describe TraitProperties do
    subject(:properties) { TraitProperties.new }
    let(:clock) { double :clock, now: Time.now }
    before { TraitProperties.clock = clock }
    after { TraitProperties.clock = nil }

    describe '#address' do
      specify { expect(properties.address).to be_a(ReplayApi::Address) }
    end

    describe '#past_event' do
      specify { expect(properties.past_event).to eq 0 }
    end

    describe '#timestamp' do
      specify { expect(properties.timestamp).to eq clock.now.to_i }
    end
  end
end
