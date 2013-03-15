module Healthyr
  class Event
    attr_accessor :event

    def initialize(*args)
      @event = ActiveSupport::Notifications::Event.new(*args)
    end

    def to_hash
      {reported_at: Time.at(event.time), time: {total: event.duration}}.tap do |hash|
        if database?
          hash[:name] = 'database'
          hash[:value] = payload[:sql]
        elsif view?
          hash[:name] = 'view'
          hash[:value] = payload[:virtual_path]
        elsif controller?
          hash[:name] = 'controller'
          hash[:value] = "#{payload[:controller]}##{payload[:action]}"
          hash[:time][:view] = payload[:view_runtime]
          hash[:time][:db] = payload[:db_runtime]
        end
      end
    end

    private
    def payload
      @payload ||= event.payload
    end

    def database?
      event.name == 'sql.active_record'
    end

    def view?
      event.name == '!render_template.action_view'
    end

    def controller?
      event.name == 'process_action.action_controller'
    end
  end
end
