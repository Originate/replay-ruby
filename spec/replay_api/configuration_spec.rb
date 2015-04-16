require 'spec_helper'

module ReplayApi
  describe Configuration do
    subject(:configuration) { Configuration.new }

    describe '#replay_server' do
      specify { expect(configuration.replay_server).to eq 'api.replay.io' }
    end

    describe '#replay_library' do
      specify { expect(configuration.replay_library).to match /^Replay Ruby \d+\.\d+\.\d+$/ }
    end

    describe '#ssl' do
      specify { expect(configuration.ssl).to eq true }
    end

    describe '#extend_event_properties' do
      it 'yields the extensions module' do
        expect { |b| configuration.extend_event_properties(&b) }.to yield_with_args(ReplayApi::EventPropertiesExtensions)
      end

      it 'includes the extensions in the properties' do
        configuration.extend_event_properties {}
        expect(ReplayApi::EventProperties.ancestors).to include(ReplayApi::EventPropertiesExtensions)
      end
    end

    describe '#extend_trait_properties' do
      it 'yields the extensions module' do
        expect { |b| configuration.extend_trait_properties(&b) }.to yield_with_args(ReplayApi::TraitPropertiesExtensions)
      end

       it 'includes the extensions in the properties' do
        configuration.extend_trait_properties {}
        expect(ReplayApi::TraitProperties.ancestors).to include(ReplayApi::TraitPropertiesExtensions)
      end
    end

    describe 'ReplayApi#configure' do
      it 'should yield a configuration object' do
        ReplayApi.configuration = Configuration.new
        expect { |b| ReplayApi.configure(&b) }.to yield_with_args(ReplayApi.configuration)
      end
    end
  end
end
