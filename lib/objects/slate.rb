class Slate
  attr_reader :x, :y, :height, :moist, :contents

  def initialize(x, y, height = 0, moist = 0)
    @x = x
    @y = y
    @height = height
    @moist = moist
    @contents = []
  end

  def biome
    @biome ||= Terrain::BiomePicker.call(height, moist)
  end

  def to_h
    {
      x: x,
      y: y,
      height: height,
      moist: moist,
      biome: biome.to_h,
      contents: contents.map(&:to_h)
    }
  end
end
