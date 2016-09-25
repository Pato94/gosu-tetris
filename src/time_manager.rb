require 'gosu'

class GosuTimeProvider
  def actual_time
    Gosu::milliseconds
  end
end

class TimeManager
  attr_accessor :last_update, :subscribers, :provider

  def initialize(provider = GosuTimeProvider.new)
    self.provider = provider
    self.last_update = provider.actual_time
    self.subscribers = []
  end

  def update
    new_update = self.provider.actual_time
    elapsed = new_update - self.last_update
    self.subscribers.each do |subscriber|
      subscriber.update(elapsed)
    end
    self.last_update = new_update
  end

  def subscribe(subscriber)
    self.subscribers << subscriber
  end
end