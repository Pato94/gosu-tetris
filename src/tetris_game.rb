require_relative 'scenario'
require_relative 'time_manager'

class TetrisGame
  attr_accessor :scenario, :time_manager

  def initialize
    self.time_manager = TimeManager.new
    self.scenario = Scenario.new(time_manager)
  end

  def update
    self.time_manager.update
  end

  def draw
    self.scenario.draw
  end

end
