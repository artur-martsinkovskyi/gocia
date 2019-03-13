class WorldEngine
  include Dimensions
  attr_reader :slates

  def initialize
    @slates = Terrain::SlateMapGenerator.call(TILE_COUNT, TILE_COUNT)
  end
end
