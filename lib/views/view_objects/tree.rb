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
      Gosu.draw_rect(
        TILE_SIZE * x + SIDEBAR_WIDTH,
        TILE_SIZE * y,
        TILE_SIZE / 2,
        TILE_SIZE / 2,
        Colors::TROPICAL_RAIN_FOREST
      )
    end
  end
end
