require 'gosu'
require_relative '../constants/dimensions'
require_relative '../services/terrain/tile_color_picker'

class Tile
  include Dimensions

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
      Terrain::TileColorPicker.call(height)
    )
  end
end
