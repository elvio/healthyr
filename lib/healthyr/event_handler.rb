module Healthyr
  class EventHandler
    EVENT_NAMES = /sql\.active_record|!render_template\.action_view|process_action\.action_controller/

    def initialize
      ActiveSupport::Notifications.subscribe(EVENT_NAMES) do |*args|
        event_received(Event.new(*args))
      end
    end

    def event_received(event)
      EventPool.add(event)
    end
  end
end
