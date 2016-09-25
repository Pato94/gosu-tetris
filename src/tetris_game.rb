require_relative 'scenario'
require_relative 'time_manager'
require_relative 'block_manager'

class TetrisGame
  attr_accessor :scenario, :time_manager, :block_manager

  def initialize
    self.time_manager = TimeManager.new
    self.scenario = Scenario.new(time_manager)
    self.block_manager = BlockManager.new(20, 20, 300, 300, 1000, time_manager)
  end

  def update
    self.time_manager.update
  end

  def draw
    self.scenario.draw
    self.block_manager.draw
  end

end
