require 'rspec'
require_relative '../src/time_manager'

class StubSubscriber
  attr_accessor :last_dt, :total_elapsed

  def initialize
    self.total_elapsed = 0
  end

  def update(dt)
    self.last_dt = dt
    self.total_elapsed += dt
  end
end

class StubTimeProvider
  attr_accessor :actual_time
  def initialize
    self.actual_time = 0
  end
end

describe 'Time manager spec' do
  it 'should update a subscriber on every update' do
    time_provider = StubTimeProvider.new
    manager = TimeManager.new(time_provider)
    subscriber = StubSubscriber.new

    manager.subscribe(subscriber)

    time_provider.actual_time = 1

    manager.update

    expect(subscriber.last_dt).to be 1
    expect(subscriber.total_elapsed).to be 1

    time_provider.actual_time = 2
    time_provider.actual_time = 3

    manager.update

    expect(subscriber.last_dt).to be 2
    expect(subscriber.total_elapsed).to be 3
  end
end