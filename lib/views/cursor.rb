class Cursor
  include Dimensions
  attr_reader :position
  COLOR = 0x70ffffff

  def initialize
    @pointer = Gosu::Image.new(
      Magick::Image.new(TILE_SIZE, TILE_SIZE) do
        self.background_color = 'black'
      end
    )
    @position = Position.new(
      left_limit: SIDEBAR_WIDTH,
      right_limit: SIDEBAR_WIDTH + MAP_SIZE - TILE_SIZE,
      top_limit: 0,
      bottom_limit: MAP_SIZE - TILE_SIZE,
      step_x: TILE_SIZE
    )
  end

  def draw
    @pointer.draw(
      *@position.absolute_position,
      1,
      1,
      1,
      COLOR
    )
  end

  def move(direction)
    @position.send(direction)
  end

  def move_to(x, y)
    @position.absolute_position = [x, y]
  end

  def relative_position
    @position.relative_position
  end
end
