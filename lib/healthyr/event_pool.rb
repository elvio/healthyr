module Healthyr
  class EventPool
    @@elements = []
    @@mutex = Mutex.new

    def self.add(element)
      @@mutex.synchronize do
        @@elements << element
      end
    end

    def self.flush
      _elements = []
      @@mutex.synchronize do
        _elements = @@elements.dup
        @@elements = []
      end

      _elements
    end

    def self.elements
      @@elements
    end
  end
end
