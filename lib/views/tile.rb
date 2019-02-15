require 'gosu'
require_relative '../constants/dimensions'
require_relative '../services/terrain/tile_color_picker'

class Tile
  include Dimensions

  attr_reader :x, :y, :color

  def initialize(x:, y:, color:)
    @x = x
    @y = y
    @color = color
  end

  def draw
    Gosu.draw_rect(
      TILE_SIZE * x + SIDEBAR_WIDTH,
      TILE_SIZE * y,
      TILE_SIZE,
      TILE_SIZE,
      color
    )
  end
end
