require 'gosu'
require 'json'
require 'rmagick'
require_relative 'sidebar'
require_relative 'map'
require_relative 'cursor'
require_relative '../constants/dimensions'
require_relative '../services/terrain/heightmap_generator'

class MainScreen < Gosu::Window
  include Dimensions

  def initialize
    super WIDTH, HEIGHT
    self.caption = 'Socia'
    @sidebar = Sidebar.new
    @heights = Terrain::HeightmapGenerator.call(TILE_COUNT, TILE_COUNT)
    @cursor = Cursor.new
    @map = Map.new(@heights)
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
    x_pos, y_pos = @cursor.position.relative_position
    {
      x_pos: x_pos + (@map.current_map_x_offset),
      y_pos: y_pos + (@map.current_map_y_offset),
      altitude: @heights[x_pos][y_pos]
    }
  end
end
