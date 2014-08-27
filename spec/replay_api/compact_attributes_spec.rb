require 'spec_helper'

module ReplayApi
  describe CompactAttributes do
    subject(:container_class) { Struct.new(:attributes) }
    let(:container) { container_class.new(attributes) }
    let(:attributes) { {} }
    before do
      container_class.include CompactAttributes
    end

    describe '#compact_attributes' do
      test_cases = {
        {} => {},
        { attribute1: nil } => {},
        { attribute1: :value1 } => { attribute1: :value1 },
        { attribute1: :value1, attribute2: nil } => { attribute1: :value1 },
        { attribute1: :value1, attribute2: {} } => { attribute1: :value1 },
        { attribute1: :value1, attribute2: { attribute3: :value3 } } => { attribute1: :value1, attribute2: { attribute3: :value3 } },
        { attribute1: :value1, attribute2: { attribute3: nil } } => { attribute1: :value1 },
        { attribute1: :value1, attribute2: { attribute3: :value3, attribute4: nil } } => { attribute1: :value1, attribute2: { attribute3: :value3 } }
      }

      test_cases.each do |input, output|
        context "when attributes is #{input.inspect}" do
          let(:attributes) { input }

          specify { expect(container.compact_attributes).to eq output }
        end
      end
    end
  end
end
