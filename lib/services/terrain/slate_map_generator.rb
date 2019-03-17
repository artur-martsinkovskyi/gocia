module Terrain
  class SlateMapGenerator < Service
    attr_reader :width, :height

    def initialize(width, height)
      @width  = width
      @height = height
    end

    def call
      heights.map.with_index do |row, i|
        row.map.with_index do |height_value, j|
          slate = Slate.new(
            i,
            j,
            height_value,
            moists[i][j]
          )
          r_value = slate.biome.r_value
          if r_value && heights[i][j] == heights[(i - r_value)...(i + r_value)].map { |r| r[(j - r_value)...(j + r_value)] }.flatten.max
            slate.contents.add(Tree.new)
          end
          slate
        end
      end
    end

    private

    def heights
      @heights ||= Terrain::HeightmapGenerator.call(width, height)
    end

    def moists
      @moists ||= Terrain::HeightmapGenerator.call(width, height)
    end
  end
end
