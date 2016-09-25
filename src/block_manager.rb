require_relative 'block'
require_relative 'shape'
require 'gosu'

shape_colors =

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
    if self.time_since_last_update > tempo
      self.time_since_last_update -= tempo
      self.blocks.each do |block|
        block.go
      end
      check_for_updates
    end
  end

  def check_for_updates
    TestingShape.new(x, y, [ 0xff4285f4, 0xffea4335, 0xfffbbc05, 0xff34a853 ].sample, self) if blocks.all? do |block|
      !block.can_you_go_down?
    end
  end

  def move_right
    self.blocks
        .select do |block|
          block.can_you_go_right?
        end
        .each do |block|
          block.move_right
        end
  end

  def move_left
    self.blocks
        .select do |block|
          block.can_you_go_left?
        end
        .each do |block|
          block.move_left
        end
  end

  def draw
    self.blocks.each do |block|
      block.draw
    end
  end

  def should_i_move?(block, ignoring = nil)
    position_available(block.x, block.y + block.size, ignoring)
  end

  def position_available(x, y, ignoring = nil)
    !out_of_bounds(x, y) && !any_block_at(x, y, ignoring)
  end

  def any_block_at(x, y, ignoring = nil)
    self.blocks
        .select do |block|
          block != ignoring
        end
        .any? do |block|
          block.are_you_at_position?(x, y)
        end
  end

  def out_of_bounds(x, y)
    block_size = 20
    (x < self.x || y < self.y) || (x + block_size > width + self.x) || (y + block_size > height + self.y)
  end
end