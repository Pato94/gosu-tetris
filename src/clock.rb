require 'gosu'

class Clock
  attr_accessor :time_elapsed, :font

  def initialize(time_manager)
    self.time_elapsed = 0
    self.font = Gosu::Font.new(20)
    time_manager.subscribe(self)
  end

  def update(dt)
    self.time_elapsed += dt
  end

  def seconds_elapsed
    self.time_elapsed / 1000
  end

  def draw
    self.font.draw(self.seconds_elapsed.to_s, 340, 20, 0)
  end
end