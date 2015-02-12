require 'spec_helper'

module ReplayApi
  describe RequestDeliverer do
    subject(:request_deliverer) { RequestDeliverer.instance }
    let(:connection) { double :connection, post: nil }
    let(:configuration) { Configuration.new.tap { |c| c.replay_key = 'my_key' } }

    before do
      allow(connection).to receive(:in_parallel).and_yield
      request_deliverer.configuration = configuration
      request_deliverer.connection = connection
    end

    describe '#post' do
      let(:event) { Event.new }
      let(:payload) { { replay_key: 'my_key' }.merge event.compact_attributes }

      it 'sends the request' do
        request_deliverer.post(uri:  '/events', payload: payload)
        {} until request_deliverer.delivery_thread.status == "sleep"
        expect(connection).to have_received(:post).with('/events', payload)
      end
    end
  end
end
