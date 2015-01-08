require 'spec_helper'

module ReplayApi
  describe TraitProperties do
    subject(:properties) { TraitProperties.new }
    
    describe '#address' do
      specify { expect(properties.address).to be_a(ReplayApi::Address) }
    end

    describe '#past_event' do
      specify { expect(properties.past_event).to eq 0 }
    end
  end
end
