require 'gosu'
require 'yaml'

require_relative '../constants/dimensions'

class Sidebar
  include Dimensions

  FONT = Gosu::Font.new(20)

  def draw(options = {})
    Gosu.draw_rect(0, 0, SIDEBAR_WIDTH, HEIGHT, Gosu::Color::WHITE)
    Gosu::Image.from_text('SOCIA', 150, bold: true).draw(0, 0, 0, 0.5, 0.5, Gosu::Color::BLACK)
    Gosu::Image.from_text(options.to_yaml.to_s, 50).draw(0, 60, 0, 0.5, 0.5, Gosu::Color::BLACK)
  end
end
