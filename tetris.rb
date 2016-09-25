require 'gosu'
require_relative 'src/tetris_game'

class MyWindow < Gosu::Window

  def initialize
    super(440, 340, false)
    self.caption = 'Tetris'
    @tetris_game = TetrisGame.new
  end

  def update
    @tetris_game.update
  end

  def draw
    @tetris_game.draw
  end
end

window = MyWindow.new
window.show