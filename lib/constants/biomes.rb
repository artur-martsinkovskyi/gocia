# frozen_string_literal: true

require 'dry-struct'

module Biomes
  class Biome < Dry::Struct
    attribute :name, Types::String
    attribute :r_value, Types::Integer.optional

    def water?
      WATER_TERRAIN.include?(self)
    end

    def land?
      LAND_TERRAIN.include?(self)
    end
  end
  SNOW       = Biome.new(name: 'snow', r_value: nil)
  ROCKS      = Biome.new(name: 'rocks', r_value: nil)
  MOUNTAIN   = Biome.new(name: 'mountain', r_value: nil)
  DESERT     = Biome.new(name: 'desert', r_value: 10)
  GRASSLAND  = Biome.new(name: 'grassland', r_value: 1)
  VALLEY     = Biome.new(name: 'valley', r_value: 1)
  COASTLINE  = Biome.new(name: 'coastline', r_value: 10)
  SHOAL      = Biome.new(name: 'shoal', r_value: nil)
  WATER      = Biome.new(name: 'water', r_value: nil)
  DEEP_WATER = Biome.new(name: 'deep_water', r_value: nil)

  LAND_TERRAIN = [
    SNOW,
    ROCKS,
    MOUNTAIN,
    DESERT,
    GRASSLAND,
    VALLEY,
    COASTLINE
  ].freeze

  WATER_TERRAIN = [
    SHOAL,
    WATER,
    DEEP_WATER
  ].freeze
end
