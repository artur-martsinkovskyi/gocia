class Sidebar
  include Dimensions

  FONT = Gosu::Font.new(20)

  def initialize(window)
    @window = window
  end

  def draw
    Gosu.draw_rect(0, 0, SIDEBAR_WIDTH, HEIGHT, Gosu::Color::WHITE)
    Gosu::Image.from_text('SOCIA', 150, bold: true).draw(0, 0, 0, 0.5, 0.5, Gosu::Color::BLACK)
    Gosu::Image.from_text(info, 50).draw(0, 60, 0, 0.5, 0.5, Gosu::Color::BLACK)
  end

  private

  attr_reader :window

  def info
    x, y = window.cursor.relative_position
      .zip([window.map.current_map_x_offset, window.map.current_map_y_offset])
      .map(&:sum)
    current_slate = window.world_engine.slates[x][y]
    current_slate.to_h.to_yaml.to_s
  end
end
