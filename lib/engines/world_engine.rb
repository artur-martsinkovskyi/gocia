class WorldEngine
  include Dimensions

  def slates
    @slates ||= Terrain::SlateMapGenerator.call(TILE_COUNT, TILE_COUNT)
  end
end
