# Healthyr
Healthyr is a performance monitor for Ruby on Rails applications. It takes advantage of [ActiveSupport::Notifications](http://api.rubyonrails.org/classes/ActiveSupport/Notifications.html) instruments to help you find slow parts of your app.

## Installation

1. Add healthyr to your Rails Gemfile:

```
gem 'healthyr'
```

2. Clone the application monitor

```
git clone https://github.com/elvio/healthyr_monitor
```
3. Start the monitor

```
$ rackup config.ru --port=[PORT]
```

4. Start your Rails app with HEALTHYR\_MONITOR\_URL environment variable pointing to the monitor you have started

```
$ HEALTHYR_MONITOR_URL="http://[SERVER]:[PORT]" rails s
```

## Usage

* Access the monitor URL to have access to charts and data about the slowest parts of your application (database, view and controller)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
