require 'gosu'
require_relative 'tile'
require_relative '../constants/dimensions'
require_relative '../services/terrain/slate_generator'

class Map
  include Dimensions

  def initialize(heights)
    @tiles = (0...TILE_COUNT).flat_map do |i|
      (0...TILE_COUNT).map do |j|
        Tile.new(i, j, height: heights[i][j])
      end
    end
  end

  def draw
    @tiles.each(&:draw)
  end
end
