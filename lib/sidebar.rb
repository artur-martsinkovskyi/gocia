class Sidebar
  WIDTH = 300
  HEIGHT = 640
  FONT = Gosu::Font.new(20)

  def draw
    Gosu.draw_rect(0, 0, WIDTH, HEIGHT, Gosu::Color::WHITE)
    Gosu::Image.from_text("SOCIA", 150, bold: true).draw(0, 0, 0, 0.5, 0.5, Gosu::Color::BLACK)
  end
end
