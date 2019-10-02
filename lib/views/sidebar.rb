# frozen_string_literal: true

class Sidebar
  include Dimensions
  include Fonts

  def initialize(window)
    @window = window
  end

  def draw
    draw_base
    draw_title
    draw_info
  end

  private

  attr_reader :window

  def draw_base
    Gosu.draw_rect(
      0,
      0,
      SIDEBAR_WIDTH,
      HEIGHT,
      Gosu::Color::BLACK
    )
  end

  def draw_title
    Gosu::Image.from_text(
      'SOCIA',
      300,
      bold: true,
      font: AMATIC_REGULAR
    ).draw(
      0,
      0,
      0,
      0.5,
      0.5,
      Gosu::Color::WHITE
    )
  end

  def draw_info
    Gosu::Image.from_text(
      %(
        Current tick: #{window.world_engine.world.tick}
        #{info}
      ),
      70,
      font: ARCHIVO_NARROW_REGULAR
    ).draw(
      0,
      110,
      0,
      0.5,
      0.5,
      Gosu::Color::WHITE
    )
  end

  def info
    x, y = cursor_world_absolute_position
    current_slate = window.world_engine.world.slates[x][y]
    current_slate.to_h.to_yaml
  end

  def cursor_world_absolute_position
    x, y = window.cursor
                 .relative_position
                 .zip(
                   [
                     window.map.current_map_x_offset,
                     window.map.current_map_y_offset
                   ]
                 ).map(&:sum)
    [x, y]
  end
end
