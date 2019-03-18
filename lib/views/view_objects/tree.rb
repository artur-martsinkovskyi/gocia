# frozen_string_literal: true

module ViewObjects
  class Tree
    include Dimensions

    attr_reader :x, :y, :tree

    def initialize(x:, y:, content:)
      @x = x
      @y = y
      @tree = content
    end

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
      Fruit.new(x: x, y: y, fruit: tree.fruit).draw
    end
  end
end
