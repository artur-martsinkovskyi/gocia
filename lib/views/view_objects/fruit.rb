module ViewObjects
  class Fruit
    include Dimensions

    attr_reader :x, :y, :fruit

    def initialize(x:, y:, fruit:)
      @x = x
      @y = y
      @fruit = fruit
    end

    def draw
      Gosu.draw_rect(
        TILE_SIZE * x + SIDEBAR_WIDTH,
        TILE_SIZE * y,
        TILE_SIZE / 4,
        TILE_SIZE / 4,
        color
      )
    end

    def color
      if fruit.poisonous?
        Gosu::Color::RED
      else
        Gosu::Color::YELLOW
      end
    end
  end
end
