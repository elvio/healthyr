module Healthyr
  describe EventPool do
    let(:event1) { stub("Event1") }
    let(:event2) { stub("Event2") }

    before :all do
      EventPool.add(event1)
      EventPool.add(event2)
    end

    describe '.add' do
      it 'adds a new element to the pool' do
        EventPool.elements.should == [event1, event2]
      end
    end

    describe '.flush' do
      it 'cleans the pool and return the elements' do
        flushed = EventPool.flush
        flushed.should == [event1, event2]
        EventPool.elements.should == []
      end
    end
  end
end
