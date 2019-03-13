class Loadscreen
  include Dimensions
  include Fonts
  include Images


  def initialize
    @content = Gosu::Image.from_text(
      %q{
      SOCIA      EXISTENTIAL SIMULATOR
      by ARTUR MARTSINKOVSKYI
      },
      300,
      font: AMATIC_REGULAR
    )
    @image = Gosu::Image.new(HEXAGON)
    @angle = 0
  end

  def draw
    @content.draw(20, 20, 0, 0.5, 0.5, Gosu::Color::WHITE)
    @image.draw_rot(400, 240, 0, @angle += 25, 0.5, 0.5, 0.2, 0.2, Gosu::Color::WHITE)
  end
end
