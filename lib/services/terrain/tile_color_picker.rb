require_relative '../../constants/colors'

module Terrain
  module TileColorPicker
    include Colors

    def self.call(elevation, moist)
      return DEEP_OCEAN if elevation < 0.05
      return OCEAN if elevation < 0.1
      return BEACH if elevation < 0.2
      if elevation > 0.8
        return SCORCHED if moist < 0.1
        return BARE if moist < 0.2
        return TUNDRA if moist < 0.5
        return WHITE
      end

      if elevation > 0.6
        return TEMPERATE_DESERT if moist < 0.33
        return SHRUBLAND if moist < 0.66
        return TAIGA
      end

      if elevation > 0.3
        return TEMPERATE_DESERT if moist < 0.16
        return GRASSLAND if moist < 0.5
        return TEMPERATE_DECIDUOUS_FOREST if moist < 0.83
        return TEMPERATE_RAIN_FOREST
      end

      return SUBTROPICAL_DESERT if moist < 0.16
      return GRASSLAND if moist < 0.33
      return TROPICAL_SEASONAL_FOREST if moist < 0.66

      TROPICAL_RAIN_FOREST
    end
  end
end
