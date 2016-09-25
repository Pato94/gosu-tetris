require_relative 'block'
require 'gosu'

class BlockManager
  attr_accessor :x, :y, :height, :width, :blocks, :tempo, :time_since_last_update

  def initialize(x, y, height, width, tempo, time_manager)
    self.x = x
    self.y = y
    self.height = height
    self.width = width
    self.blocks = []
    self.tempo = tempo
    self.time_since_last_update = 0
    time_manager.subscribe(self)
  end

  def update(dt)
    if Gosu::button_down? Gosu::KbLeft or Gosu::button_down? Gosu::GpLeft
      move_left
    end
    if Gosu::button_down? Gosu::KbRight or Gosu::button_down? Gosu::GpRight
      move_right
    end
    self.time_since_last_update += dt
    if self.time_since_last_update > tempo or Gosu::button_down? Gosu::KbDown or Gosu::button_down? Gosu::GpDown
      if self.time_since_last_update > tempo
        self.time_since_last_update -= tempo
      end
      self.blocks.each do |block|
        block.go
      end
      check_for_updates
    end
  end

  def check_for_updates
    Block.new(x, y, 0xffaaaaaa, self) if blocks.all? do |block|
      !should_i_move?(block)
    end
  end

  def move_right
    self.blocks.select do |block|
      should_i_move?(block)
    end.each do |block|
      block.move_right
    end
  end

  def move_left
    self.blocks.select do |block|
      should_i_move?(block)
    end.each do |block|
      block.move_left
    end
  end

  def draw
    self.blocks.each do |block|
      block.draw
    end
  end

  def should_i_move?(block)
    position_available(block.x, block.y + block.size)
  end

  def position_available(x, y)
    !out_of_bounds(x, y) && !any_block_at(x, y)
  end

  def any_block_at(x, y)
    self.blocks.any? do |block|
      block.x == x && block.y == y
    end
  end

  def out_of_bounds(x, y)
    block_size = 20
    (x < self.x || y < self.y) || (x + block_size > width + self.x) || (y + block_size > height + self.y)
  end
end