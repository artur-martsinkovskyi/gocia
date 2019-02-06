module Colors
  module Tile

    def color_by_elevation(elevation)
      case elevation
      when 0.8..1   then 0xFF996666
      when 0.6..0.8 then 0xFF99FF00
      when 0.4..0.6 then 0xFFCCFF99
      when 0.2..0.4 then 0xFF66CCFF
      when 0.0..0.2 then 0xFF0033FF
      else
        if elevation < 0
          0xFF003366
        else
          0xFFFFFFFF
        end
      end
    end

    module_function :color_by_elevation
  end
end
