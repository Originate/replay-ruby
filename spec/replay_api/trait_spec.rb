require 'spec_helper'

module ReplayApi
  describe Trait do
    subject(:trait) { Trait.new }

    describe '#properties' do
      specify { expect(trait.properties).to be_a(ReplayApi::TraitProperties) }
    end
  end
end
