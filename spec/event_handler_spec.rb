require 'spec_helper'

module Healthyr
  describe EventHandler do
    describe ".start" do
      it "subscribes to ActiveSupport::Notifications" do
        ActiveSupport::Notifications.should_receive(:subscribe).with(EventHandler::EVENT_NAMES)
        described_class.new
      end
    end

    describe ".event_received" do
      let(:event) { stub("Event") }

      before do
        ActiveSupport::Notifications.stub(:subscribe)
      end

      subject do
        described_class.new
      end

      it "adds a new event to the event pool" do
        EventPool.should_receive(:add).with(event)
        subject.event_received(event)
      end
    end
  end
end
