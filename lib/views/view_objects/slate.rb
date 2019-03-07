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
        slate.biome.color
      )
      slate.contents.each do |content|
        Object.const_get("ViewObjects::#{content.class}").new(x: x, y: y, tree: content).draw
      end
    end
  end
end
