module Colors
  include Biomes

  WHITE      = 0xFFFFFFFF
  BLACK      = 0xFF000000
  DEEP_BLUE  = 0xFF003366
  BLUE       = 0xFF0033FF
  LIGHT_BLUE = 0xFF66CCFF
  GREEN      = 0xFFCCFF99
  DARK_GREEN = 0xFF99FF00
  BROWN      = 0xFF996666
  GREY       = 0xFFD3D3D3
  SANDY      = 0xFFFCECDF
  DESERT_YELLOW = 0xFFBA9561
  LEAF_GREEN = 0xFF30760D

  BIOME_COLOR = lambda do |biome|
    case biome
    when SNOW
      WHITE
    when ROCKS
      GREY
    when MOUNTAIN
      BROWN
    when DESERT
      DESERT_YELLOW
    when GRASSLAND
      DARK_GREEN
    when VALLEY
      GREEN
    when COASTLINE
      SANDY
    when SHOAL
      LIGHT_BLUE
    when WATER
      BLUE
    when DEEP_WATER
      DEEP_BLUE
    else
      raise ArgumentError, "Unknown biome."
    end
  end
end
