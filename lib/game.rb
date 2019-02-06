require 'gosu'
require_relative 'sidebar'
require 'rmagick'

class Game < Gosu::Window
  SIZE = 640

  def initialize
    super SIZE + Sidebar::WIDTH, SIZE
    self.caption = 'Socia'
    @sidebar = Sidebar.new
    @tiles = (0..63).flat_map do |i|
      (0..63).map do |j|
        Tile.new(i, j)
      end
    end
    @cursor_position = [0, 0]
  end

  def update
    if Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
      @player.turn_left
    end
    if Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
      @player.turn_right
    end
    if Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_BUTTON_0
      @player.accelerate
    end
  end

  def draw
    @sidebar.draw
    @tiles.each(&:draw)
    color = Gosu::Color::BLACK.dup
    color.alpha = 128
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end
end

class Tile
  SIZE = Game::SIZE / 64
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def draw
    memoized_colors[[x, y]] = mix_color unless memoized_colors[[x, y]]
    Gosu.draw_rect(SIZE * x + Sidebar::WIDTH, SIZE * y, SIZE, SIZE, @memoized_colors[[x, y]])
  end

  def memoized_colors
    @memoized_colors ||= {}
  end

  def mix_color
    color = Gosu::Color::BLACK.dup
    color.red = rand(256 - 40) + 40
    color.green = rand(256 - 40) + 40
    color.blue = rand(256 - 40) + 40
    color
  end
end

class Cursor
  def initialize
    @pointer = Gosu::Image(
      Magick::Image.new(2 * RADIUS, 2 * RADIUS) do
        self.background_color = "black"
      end
    )
    @cursor = [0, 0]
  end

  def left
  end

  def right
  end

  def up
  end

  def down
  end
end

Game.new.show
