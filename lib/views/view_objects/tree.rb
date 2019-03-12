module ViewObjects
  class Tree
    include Dimensions

    attr_reader :x, :y, :tree

    def initialize(x:, y:, tree:)
      @x = x
      @y = y
      @tree = tree
    end

    def draw
      draw_base
      fruit.draw if tree.fruit
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

    def fruit
      Fruit.new(x: x, y: y, fruit: tree.fruit)
    end
  end
end
