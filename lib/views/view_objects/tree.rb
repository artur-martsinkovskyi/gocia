# frozen_string_literal: true

module ViewObjects
  class Tree < ViewObject
    include Dimensions

    attribute :tree, Types.Instance(::Tree)

    def draw
      draw_base
      draw_fruit
    end

    private

    def draw_base
      Gosu.draw_rect(
        TILE_SIZE * x + SIDEBAR_WIDTH,
        TILE_SIZE * y,
        TILE_SIZE / 2,
        TILE_SIZE / 2,
        Colors::LEAF_GREEN
      )
    end

    def draw_fruit
      Fruit.new(x: x, y: y, fruit: tree.fruit).draw if tree.fruit
    end
  end
end
