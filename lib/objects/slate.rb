class Slate
  attr_accessor :x, :y, :height, :moist

  def initialize(x, y, height = 0, moist = 0)
    @x = x
    @y = y
    @height = height
    @moist = moist
  end

  def color
    @color ||= Terrain::TileColorPicker.call(height, moist)
  end
end
