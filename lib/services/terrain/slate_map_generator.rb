# frozen_string_literal: true

module Terrain
  class SlateMapGenerator < Service
    attr_reader :width, :height

    def initialize(world, width, height)
      @world  = world
      @width  = width
      @height = height
    end

    def call
      heights.map.with_index do |row, i|
        row.map.with_index do |height_value, j|
          Slate.new(
            @world,
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
      @moists ||= Terrain::HeightmapGenerator.call(width, height, 300)
    end
  end
end
