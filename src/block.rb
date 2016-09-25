require 'gosu'
require_relative 'square'

class Block
  attr_accessor :square, :manager

  def initialize(x, y, color, manager)
    self.square = Square.new(x, y, 20, color)
    self.manager = manager
    self.manager.blocks << self
  end

  def go
    if manager.should_i_move?(self)
      new_position(x, y + size)
    end
  end

  def new_position(new_x, new_y)
    self.square.x = new_x
    self.square.y = new_y
  end

  def draw
    self.square.draw
  end

  def x
    self.square.x
  end

  def y
    self.square.y
  end

  def size
    self.square.size
  end
end