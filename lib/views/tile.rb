require 'gosu'
require_relative '../constants/dimensions'
require_relative './colors/tile'

class Tile
  include Dimensions
  include Colors::Tile

  attr_reader :x, :y, :height

  def initialize(x, y, height: 0)
    @x = x
    @y = y
    @height = height
  end

  def draw
    Gosu.draw_rect(
      TILE_SIZE * x + SIDEBAR_WIDTH,
      TILE_SIZE * y,
      TILE_SIZE,
      TILE_SIZE,
      color_by_elevation(height)
    )
  end
end
