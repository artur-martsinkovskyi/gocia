require_relative '../service'
require_relative '../../constants/colors'

module Terrain
  class TileColorPicker < Service
    include Colors
    private

    def initialize(elevation)
      @elevation = elevation
    end

    def call
      case @elevation
      when 0.95..1   then WHITE
      when 0.9..0.95 then GREY
      when 0.8..0.9  then BROWN
      when 0.7..0.8  then DESERT_YELLOW
      when 0.6..0.7  then DARK_GREEN
      when 0.3..0.6  then GREEN
      when 0.2..0.3  then SANDY
      when 0.1..0.2  then LIGHT_BLUE
      when 0.05..0.1 then BLUE
      when 0.0..0.1  then DEEP_BLUE
      end
    end
  end
end
