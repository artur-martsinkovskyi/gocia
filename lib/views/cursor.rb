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
        self.background_color = 'black'
      end
    )
    @position = Position.new(
      left_limit: SIDEBAR_WIDTH,
      right_limit: SIDEBAR_WIDTH + MAP_SIZE - TILE_SIZE,
      top_limit: 0,
      bottom_limit: MAP_SIZE - TILE_SIZE,
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

  def relative_position
    @position.relative_position
  end
end
