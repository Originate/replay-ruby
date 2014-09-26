require 'spec_helper'

module ReplayApi
  describe Client do
    subject(:client) { Client.new(configuration) }
    let(:connection) { double :connection, post: nil }
    let(:configuration) { Configuration.new.tap { |c| c.replay_key = 'my_key' } }
    before do
      client.connection = connection
    end

    describe '#event' do
      let(:event) { Event.new }
      let(:payload) { { replay_key: 'my_key' }.merge event.compact_attributes }

      it 'yields the provided event' do
        expect { |b| client.event(event, &b) }.to yield_with_args(event)
      end

      it 'posts the event' do
        client.event(event)
        expect(connection).to have_received(:post).with('/events', payload)
      end
    end

    describe '#trait' do
      let(:trait) { Trait.new }
      let(:payload) { { replay_key: 'my_key' }.merge trait.compact_attributes }

      it 'yields the provided trait' do
        expect { |b| client.trait(trait, &b) }.to yield_with_args(trait)
      end

      it 'posts the trait' do
        client.trait(trait)
        expect(connection).to have_received(:post).with('/traits', payload)
      end
    end
  end
end
