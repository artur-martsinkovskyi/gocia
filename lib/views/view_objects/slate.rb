# frozen_string_literal: true

module ViewObjects
  class Slate
    include Dimensions

    attr_reader :x, :y, :slate

    def initialize(x:, y:, slate:)
      @x = x
      @y = y
      @slate = slate
    end

    def draw
      Gosu.draw_rect(
        TILE_SIZE * x + SIDEBAR_WIDTH,
        TILE_SIZE * y,
        TILE_SIZE,
        TILE_SIZE,
        Colors::BIOME_COLOR[slate.biome]
      )
      slate.contents.each do |content|
        Object.const_get("ViewObjects::#{content.class}").new(x: x, y: y, content: content).draw
      end
    end
  end
end
