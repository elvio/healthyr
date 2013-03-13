require 'spec_helper'
require 'json'

module Healthyr
  describe EventAgent do
    class EventAgent::AgentThread
      def initialize(duration, &block)
        block.call
      end
    end

    class EventAgent::Envelope
      def instance_id
        "test-10"
      end
    end

    let(:monitor_url) { "http://monitor-url" }
    let(:update_interval) { 10 }


    describe "#initialize" do
      let(:event1) { stub("Event1", to_hash: Hash[name: "event1"]) }
      let(:event2) { stub("Event2", to_hash: Hash[name: "event2"]) }
      let(:data) { {from: 'test-10', events: [event1.to_hash, event2.to_hash]}.to_json }
      let(:response) { stub("Response", code: 200) }

      before do
        EventPool.add(event1)
        EventPool.add(event2)
      end

      it "sends the events data to monitor" do
        Net::HTTP.should_receive(:post_form).with(monitor_url, {data: data}).and_return(response)
        EventAgent.new(monitor_url, update_interval)
      end
    end
  end
end
