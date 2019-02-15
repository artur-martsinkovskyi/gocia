require_relative 'heightmap_generator'
require_relative '../../objects/slate'
require_relative '../service'

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
          Slate.new(
            i,
            j,
            height_value,
            moists[i][j]
          )
        end
      end
    end

    private

    def heights
      @heights ||= Terrain::HeightmapGenerator.call(width, height)
    end

    def moists
      @moists ||= Terrain::HeightmapGenerator.call(width, height, 12)
    end
  end
end
