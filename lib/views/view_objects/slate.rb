# frozen_string_literal: true

require_relative 'view_object'

module ViewObjects
  class Slate < ViewObject
    include Dimensions

    attribute :slate, Types.Instance(::Slate)

    def draw
      Gosu.draw_rect(
        TILE_SIZE * x + SIDEBAR_WIDTH,
        TILE_SIZE * y,
        TILE_SIZE,
        TILE_SIZE,
        Colors::BIOME_COLOR[slate.biome]
      )
      slate.contents.each do |content|
        Object.const_get("ViewObjects::#{content.class}").new(x: x, y: y, content.type.to_sym => content).draw
      end
    end
  end
end
