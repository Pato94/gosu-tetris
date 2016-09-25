require_relative 'square'
require_relative 'clock'

class Scenario
  attr_accessor :main_square, :clock

  def initialize(time_manager)
    self.main_square = Square.new(20, 20, 300, 0xffffffff)
    self.clock = Clock.new(time_manager)
  end

  def draw
    self.clock.draw
    self.main_square.draw
  end
end