# frozen_string_literal: true

require_relative 'view_object'

module ViewObjects
  class Actor < ViewObject
    include Dimensions

    attribute :actor, Types.Instance(::Actor)

    def draw
      Gosu.draw_rect(
        TILE_SIZE * x + SIDEBAR_WIDTH + (TILE_SIZE / 2),
        TILE_SIZE * y + (TILE_SIZE / 2),
        TILE_SIZE / 2,
        TILE_SIZE / 2,
        Gosu::Color::FUCHSIA
      )
    end
  end
end
