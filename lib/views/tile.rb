require 'gosu'
require_relative '../constants/dimensions'

class Tile
  include Dimensions

  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def draw
    Gosu.draw_rect(
      TILE_SIZE * x + SIDEBAR_WIDTH,
      TILE_SIZE * y,
      TILE_SIZE,
      TILE_SIZE,
      mix_color
    )
  end

  def memoized_colors
    @memoized_colors ||= {}
  end

  def mix_color
    color = Gosu::Color::BLACK.dup
    color.red = rand(256 - 40) + 40
    color.green = rand(256 - 40) + 40
    color.blue = rand(256 - 40) + 40
    color
  end
end
