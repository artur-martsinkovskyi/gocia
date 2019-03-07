require_relative 'colors'

module Biomes
  Biome = Struct.new(:name, :color, :r_value)
  SNOW       = Biome.new('snow', ::Colors::WHITE, nil)
  ROCKS      = Biome.new('rocks', ::Colors::GREY, nil)
  MOUNTAIN   = Biome.new('mountain', ::Colors::BROWN, nil)
  DESERT     = Biome.new('desert', ::Colors::DESERT_YELLOW, 10)
  GRASSLAND  = Biome.new('grassland', ::Colors::DARK_GREEN, 1)
  VALLEY     = Biome.new('valley', ::Colors::GREEN, 1)
  COASTLINE  = Biome.new('coastline', ::Colors::SANDY, 10)
  SHOAL      = Biome.new('shoal', ::Colors::LIGHT_BLUE, nil)
  WATER      = Biome.new('water', ::Colors::BLUE, nil)
  DEEP_WATER = Biome.new('deep_water', ::Colors::DEEP_BLUE, nil)
end
