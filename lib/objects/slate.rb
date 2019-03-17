require 'set'

class Slate < GameObject
  attr_reader :x, :y, :height, :moist, :contents

  def initialize(x, y, height = 0, moist = 0)
    @x = x
    @y = y
    @height = height
    @moist = moist
    @contents = Set.new
  end

  def biome
    @biome ||= Terrain::BiomePicker.call(height, moist)
  end

  def to_h
    super.merge(
      x: x,
      y: y,
      height: height,
      moist: moist,
      biome: biome.to_h,
      contents: contents.map(&:to_h)
    )
  end
end
