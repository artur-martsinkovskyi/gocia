require 'gosu'
require 'json'
require 'rmagick'
require_relative 'sidebar'
require_relative 'map'
require_relative 'cursor'
require_relative '../constants/dimensions'
require_relative '../services/terrain/slate_map_generator'

class MainScreen < Gosu::Window
  include Dimensions

  def initialize
    super WIDTH, HEIGHT
    self.caption = 'Socia'
    @sidebar = Sidebar.new
    @slates = Terrain::SlateMapGenerator.call(TILE_COUNT, TILE_COUNT)
    @map    = Map.new(@slates)
    @cursor = Cursor.new
  end

  def draw
    @sidebar.draw(sidebar_info)
    @map.draw
    @cursor.draw
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end

  def button_up(id)
    if id == Gosu::KB_LEFT
      @cursor.move(:left)
    elsif id == Gosu::KB_RIGHT
      @cursor.move(:right)
    elsif id == Gosu::KB_UP
      @cursor.move(:up)
    elsif id == Gosu::KB_DOWN
      @cursor.move(:down)
    elsif [Gosu::KB_W, Gosu::KB_S, Gosu::KB_A, Gosu::KB_D].include?(id)
      @map.move(id)
    else
      super
    end
  end

  private

  def sidebar_info
    x, y = @cursor.position
                  .relative_position
                  .zip([@map.current_map_x_offset, @map.current_map_y_offset])
                  .map(&:sum)
    current_slate = @slates[x][y]
    {
      x_pos: current_slate.x,
      y_pos: current_slate.y,
      height: current_slate.height,
      moist: current_slate.moist
    }
  end
end
