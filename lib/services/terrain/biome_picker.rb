# frozen_string_literal: true

module Terrain
  module BiomePicker
    include Biomes

    def self.call(elevation, moist)
      case elevation
      when 0.95..1
        SNOW
      when 0.9..0.95
        ROCKS
      when 0.8..0.9
        MOUNTAIN
      when 0.7..0.8
        DESERT
      when 0.6..0.7
        if moist < 0.8
          GRASSLAND
        else
          SHOAL
        end
      when 0.3..0.6
        VALLEY
      when 0.2..0.3
        COASTLINE
      when 0.1..0.2
        SHOAL
      when 0.05..0.1
        WATER
      when 0.0..0.05
        DEEP_WATER
      end
    end
  end
end
