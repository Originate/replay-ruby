require 'spec_helper'

module ReplayApi
  describe Client do
    subject(:client) { Client.new(configuration, deliverer) }
    let(:deliverer) { double :deliverer, post: nil }
    let(:configuration) do
      Configuration.new.tap do |c|
        c.replay_key = 'my_key'
        c.replay_library = 'my_ver'
      end
    end

    describe '#event' do
      let(:event) { Event.new }
      let(:payload) { { replay_key: 'my_key', replay_lib: 'my_ver' }.merge event.compact_attributes }

      it 'yields the provided event' do
        expect { |b| client.event(event, &b) }.to yield_with_args(event)
      end

      it 'posts the event' do
        client.event(event)
        expect(deliverer).to have_received(:post).with(uri: '/events', payload: payload)
      end
    end

    describe '#trait' do
      let(:trait) { Trait.new }
      let(:payload) { { replay_key: 'my_key', replay_lib: 'my_ver' }.merge trait.compact_attributes }

      it 'yields the provided trait' do
        expect { |b| client.trait(trait, &b) }.to yield_with_args(trait)
      end

      it 'posts the trait' do
        client.trait(trait)
        expect(deliverer).to have_received(:post).with(uri: '/traits', payload: payload)
      end
    end
  end
end
