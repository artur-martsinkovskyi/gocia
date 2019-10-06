# frozen_string_literal: true

module Terrain
  class SlateMapGenerator < Service
    attribute :world, Types.Instance(World)
    attribute :width, Types::Integer
    attribute :height, Types::Integer

    def call
      heights.map.with_index do |row, i|
        row.map.with_index do |height_value, j|
          Slate.new(
            x: i,
            y: j,
            height: height_value,
            moist: moists[i][j]
          )
        end
      end
    end

    private

    memoize def heights
      Terrain::HeightmapGenerator.call(width, height)
    end

    memoize def moists
      Terrain::HeightmapGenerator.call(width, height, 300)
    end
  end
end
