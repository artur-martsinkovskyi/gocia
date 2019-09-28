# frozen_string_literal: true

require_relative 'view_object'

module ViewObjects
  class Fruit < ViewObject
    include Dimensions

    attribute :fruit, Types.Instance(::Fruit)

    def draw
      return unless fruit

      Gosu.draw_rect(
        TILE_SIZE * x + SIDEBAR_WIDTH,
        TILE_SIZE * y,
        TILE_SIZE / 4,
        TILE_SIZE / 4,
        color
      )
    end

    private

    def color
      if fruit.poisonous?
        Gosu::Color::RED
      else
        Gosu::Color::YELLOW
      end
    end
  end
end
