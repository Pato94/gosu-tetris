require 'gosu'
require_relative 'square'

class Block
  attr_accessor :square, :manager

  def initialize(x, y, color, manager)
    self.square = Square.new(x, y, 19, color)
    self.manager = manager
    self.manager.blocks << self unless manager.nil?
  end

  def go
    if manager.should_i_move?(self)
      new_position(x, y + size)
    end
  end

  def move_right
    new_x = x + size
    if manager.position_available(new_x, y)
      new_position(new_x, y)
    end
  end

  def move_left
    new_x = x - size
    if manager.position_available(new_x, y)
      new_position(new_x, y)
    end
  end

  def can_you_go_left?
    manager.should_i_move?(self)
  end

  def can_you_go_right?
    manager.should_i_move?(self)
  end

  def can_you_go_down?
    manager.should_i_move?(self)
  end

  def are_you_at_position?(x, y)
    self.x == x and self.y == y
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
    self.square.size + 1
  end
end