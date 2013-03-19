require 'rails'
require 'net/http'
require 'healthyr/event'
require 'healthyr/event_handler'
require 'healthyr/event_agent'
require 'healthyr/event_pool'

module Healthyr
  def self.boot(app)
    start_event_handler
    start_event_agent
  end

  def self.start_event_handler
    EventHandler.new
  end

  def self.start_event_agent
    EventAgent.new(monitor_url, update_interval)
  end

  def self.monitor_url
    if ENV['HEALTHYR_MONITOR_URL']
      URI.parse(ENV['HEALTHYR_MONITOR_URL'] + "/events")
    else
      raise ArgumentError.new "Healthyr could not find environment variable: HEALTHYR_MONITOR_URL"
    end
  end

  def self.update_interval
    interval = ENV['HEALTHYR_UPDATE_INTERVAL'].to_i
    interval < 5 ? 5 : interval
  end
end

require 'healthyr/railtie'
