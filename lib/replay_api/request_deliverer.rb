module ReplayApi
  class RequestDeliverer
    include Singleton

    attr_accessor :configuration
    attr_accessor :connection
    attr_reader :request_buffer
    attr_reader :time_last_write
    attr_reader :delivery_thread

    def initialize(configuration=ReplayApi.configuration)
      @configuration ||= configuration
      @time_last_write = Time.now
      @request_buffer = Queue.new

      start_delivery_thread
    end

    def post(request)
      @request_buffer.push(request)
    end

    private

    def start_delivery_thread
      return if @delivery_thread

      @delivery_thread = Thread.new do
        loop do
          sendRequests(inboundRequests)
          @time_last_write = Time.now
        end
      end
    end

    def inboundRequests
      requests = [request_buffer.pop]
      requests << request_buffer.pop until (request_buffer.empty? or batch_full?(requests) or max_delay_exceeded?)
      requests
    end

    def sendRequests(requests)
      connection.in_parallel do
        requests.each do |request|
          connection.post request[:uri], request[:payload]
        end
      end
    end

    def batch_full?(requests)
      requests.size >= configuration.max_request_batch_size
    end

    def max_delay_exceeded?
      time_since_last_write > configuration.max_request_batch_delay
    end


    def time_since_last_write
      Time.now - time_last_write
    end

    def connection
      @connection ||= Faraday.new(url: "#{protocol}://#{configuration.replay_server}") do |conn|
        conn.request  :json
        conn.response :json
        conn.adapter  :typhoeus
      end
    end

    def protocol
      return 'http' unless configuration.ssl?
      'https'
    end
  end
end
