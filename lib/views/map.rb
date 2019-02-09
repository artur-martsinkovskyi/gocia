require 'gosu'
require_relative 'tile'
require_relative '../constants/dimensions'

class Map
  include Dimensions

  def initialize(heights, moists)
    @tiles = (0...TILE_COUNT).flat_map do |i|
      (0...TILE_COUNT).map do |j|
        Tile.new(i, j, height: heights[i][j], moist: moists[i][j])
      end
    end
  end

  def draw
    @tiles.each(&:draw)
  end
end
