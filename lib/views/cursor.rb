require 'gosu'
require 'rmagick'
require_relative '../constants/dimensions'
require_relative '../position'

class Cursor
  include Dimensions
  attr_reader :position

  def initialize
    @pointer = Gosu::Image.new(
      Magick::Image.new(TILE_SIZE, TILE_SIZE) do
        self.background_color = "black"
      end
    )
    @position = Position.new(
      position_x: SIDEBAR_WIDTH,
      step_x: TILE_SIZE
    )
  end

  def draw
    @pointer.draw(
      *@position.absolute_position,
      1,
      1,
      1,
      0x70ffffff
    )
  end

  def move(direction)
    @position.send(direction)
  end
end
