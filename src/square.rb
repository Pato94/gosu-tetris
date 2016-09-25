require 'gosu'

class Square
  attr_accessor :x, :y, :size, :color

  def initialize(x, y, size, color)
    self.x = x
    self.y = y
    self.size = size
    self.color = color
  end

  def draw
    Gosu.draw_quad(x, y, color,
              x + size, y, color,
              x, y + size, color,
              x + size, y + size, color, 0)
  end
end