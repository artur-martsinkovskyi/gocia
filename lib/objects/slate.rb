require 'yaml'
require_relative '../services/terrain/tile_color_picker'
require_relative 'tree'

class Slate
  attr_accessor :x, :y, :height, :moist, :contents

  def initialize(x, y, height = 0, moist = 0)
    @x = x
    @y = y
    @height = height
    @moist = moist
    @contents = [height > 0.9 ? Tree.new : nil]
  end

  def color
    @color ||= Terrain::TileColorPicker.call(height, moist)
  end

  def to_h
    {
      x: x,
      y: y,
      height: height,
      moist: moist,
      color: color
    }
  end
end
