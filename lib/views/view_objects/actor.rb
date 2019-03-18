# frozen_string_literal: true

module ViewObjects
  class Actor
    include Dimensions

    attr_reader :x, :y, :actor

    def initialize(x:, y:, content:)
      @x = x
      @y = y
      @actor = content
    end

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
