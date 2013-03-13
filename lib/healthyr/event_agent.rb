module Healthyr
  class EventAgent

    def initialize(monitor_url, update_interval)
      AgentThread.new(update_interval) do
        events = EventPool.flush
        envelope = Envelope.new(events)

        begin
          response = Net::HTTP.post_form(monitor_url, {data: envelope.content})
          if response.code != 200
            Rails.logger.error "Healthyr failed to send data to monitor"
          end
        rescue Errno::ECONNREFUSED
          Rails.logger.error "Healthyr could not connect to '#{monitor_url}'"
        end
      end
    end

    private

    class Envelope
      def initialize(events)
        @events = events
      end

      def content
        Hash[from: instance_id, events: @events.map(&:to_hash)].to_json
      end

      def instance_id
        "#{Socket.gethostname}-#{$$}"
      end
    end

    class AgentThread
      def initialize(duration, &block)
        Thread.abort_on_exception = true
        Thread.new do
          while true
            sleep duration
            block.call
          end
        end
      end
    end

  end
end
